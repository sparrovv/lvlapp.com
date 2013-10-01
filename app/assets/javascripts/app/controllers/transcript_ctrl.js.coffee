LApp.controller "TranscriptCtrl", ($scope, transcriptFactory, Stats, Key, audioVideo) ->
  $scope.currentState = 'paused'
  $scope.level = 'normal'
  $scope.transcriptFactory = transcriptFactory
  $scope.transcript = transcriptFactory.transcript
  $scope.transcriptTimeRange = LApp.getTimeRange($scope.transcript)
  $scope.currentLine = $scope.transcript[0]

  $scope.spellChecker = new LApp.spellCheckService(transcriptFactory, $scope, Stats)
  $scope.stats = Stats # just for debug

  videoCallbacks = (videoPlayer) ->
    onVideoStart = ->
      $('#transcript-player').focus()
      transcriptFactory.setupBlanks($scope.level)
      $scope.$digest()
      $scope.play() if $scope.currentState == 'paused'
      Stats.init
        level: 'normal', audio_video_id: audioVideo.id, blanks: transcriptFactory.numberOfBlanks()

    onVideoEnded = ->
      Stats.persist()

    videoPlayer.onVideoStart(onVideoStart)
    videoPlayer.onVideoEnded(onVideoEnded)

  LApp.VideoPlayerFactory.init($scope, window.isYoutubeVideo, videoCallbacks)

  $scope.navigator = LApp.navigateOverTranscript($scope, transcriptFactory)
  $scope.currentLineTopPosition = 30
  $scope.$watch "currentLine", ->
    start = 30
    lineHeight = 32.5
    $scope.currentLineTopPosition = start - ($scope.currentLine.index * lineHeight)
    LApp.highlightService $scope.currentLine

  $scope.setCurrentLine = (line) ->
    $scope.currentLine = line
    $scope.videoPlayer.setCurrentTime(line.time)
    $scope.$digest()

  $scope.nextLineTimeout = null
  $scope.clearNextLineTimeout = ->
    clearTimeout($scope.nextLineTimeout) 
    $scope.nextLineTimeout = null

  $scope.pauseOnNonFinishedLine = ->
    pauseABitLater = ->
      if not $scope.currentLine.isMatchingOrignal()
        $scope.videoPlayer.pause()

    if not $scope.nextLineTimeout
      $scope.nextLineTimeout = setTimeout(pauseABitLater, 500)

  $scope.$on "newLine", (event, newLine) ->
    if $scope.currentLine.isMatchingOrignal()
      $scope.clearNextLineTimeout()
      $scope.currentLine = newLine
      $scope.$digest()
    else
      $scope.pauseOnNonFinishedLine()

  bindPlayPause = ->
    $(document).keydown (e) ->
      $scope.togglePlayer() if Key.isEnter(e.keyCode)

  bindPlayPause()
  unbindKeyDownKeyPress = ->
    $(document).unbind('keypress')
    $(document).unbind('keydown')
    bindPlayPause()

  bindKeyDownKeyPress = ->
    $(document).keypress (event) ->
      return false  if Key.isSpecial(event.which)

      letter = String.fromCharCode(event.which)
      $scope.spellChecker.nextLetter letter

    $(document).keydown (e) ->
      $scope.navigator.lineDown()    if Key.isKeyDown(e.keyCode)
      $scope.navigator.lineUp()      if Key.isKeyUp(e.keyCode)
      $scope.navigator.beginningOfline() if Key.isKeyLeft(e.keyCode)
      $scope.spellChecker.skipWord() if Key.isTab(e.keyCode)

      if Key.isBackspace(e.keyCode)
        e.preventDefault()
        currentLineWithBlanks = transcriptFactory.firstWithBlanks()
        currentLineWithBlanks.removeLastFromBuffer()

        $scope.$apply()

      return false  if Key.isSpecial(e.keyCode)

  $(document).click (event) ->
    targetElInsideTranscriptPlayer = $(event.target).parents('#transcript-player').length == 1
    $scope.pause() if not targetElInsideTranscriptPlayer

  $scope.togglePlayer = ->
    if $scope.currentState == 'paused'
      $scope.play()
    else
      $scope.pause()

  # As a workaround to make it possible to play the current paused line, it starts from the beginning.
  $scope.play = ->
    $scope.currentState = 'playing'
    bindKeyDownKeyPress()

    if $scope.currentLine.isMatchingOrignal()
      $scope.videoPlayer.play()
    else
      line = $scope.currentLine
      $scope.videoPlayer.setCurrentTime(line.time)

    if !$scope.$$phase
      $scope.$digest()

  $scope.pause = ->
    $scope.currentState = 'paused'
    unbindKeyDownKeyPress()
    $scope.clearNextLineTimeout()
    $scope.videoPlayer.pause()
    $scope.$digest()

  $scope.onPlayClick = (level)->
    $scope.level = level
    $scope.play()

  window.scope = $scope
