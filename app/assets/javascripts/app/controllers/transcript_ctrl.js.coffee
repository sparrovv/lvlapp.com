LApp.controller "TranscriptCtrl", ($scope, GameConfig, GameStates, transcriptFactory, Stats, Key, audioVideo) ->
  $scope.currentState = GameStates.loading
  $scope.level = 'normal'

  $scope.stats = Stats
  $scope.transcript = transcriptFactory.transcript
  $scope.transcriptTimeRange = LApp.getTimeRange($scope.transcript)
  $scope.currentLine = $scope.transcript[0]

  $scope.spellChecker = new LApp.spellCheckService(transcriptFactory, $scope, Stats)

  bindNewLineListener = ->
    $scope.$on "newLine", (event, newLine) ->
      if $scope.currentLine.isMatchingOrignal()
        $scope.clearNextLineTimeout()
        $scope.currentLine = newLine
        $scope.$digest()
      else
        $scope.pauseOnNonFinishedLine()

  videoCallbacks = (videoPlayer) ->
    onVideoStart = ->
      return if $scope.currentState != GameStates.loading # safeguard, so it won't triggered twice
      console.log 'videoStarted'
      transcriptFactory.setupBlanks($scope.level)
      Stats.init
        level: $scope.level, audio_video_id: audioVideo.id, blanks: transcriptFactory.numberOfBlanks()
      $scope.$digest()
      $scope.play()
      bindNewLineListener()
      $('#transcript-player').focus()
      $(document).bind 'click', onClickOutsidePlayer
      bindPlayPause()

    onVideoEnded = ->
      $(document).unbind 'click', onClickOutsidePlayer
      $scope.currentState = GameStates.finished
      Stats.persist()

    $scope.currentState = GameStates.setup
    videoPlayer.onVideoStart(onVideoStart)
    videoPlayer.onVideoEnded(onVideoEnded)

  LApp.VideoPlayerFactory.init($scope, GameConfig.isYoutubeVideo(), videoCallbacks)

  $scope.navigator = LApp.navigateOverTranscript($scope, transcriptFactory)
  $scope.currentLineTopPosition = GameConfig.lineStartPosition
  $scope.$watch "currentLine", ->
    $scope.currentLineTopPosition = GameConfig.lineStartPosition - ($scope.currentLine.index * GameConfig.lineHeight)
    LApp.highlightService $scope.currentLine

  $scope.setCurrentLine = (line) ->
    $scope.clearNextLineTimeout()
    $scope.currentLine = line
    $scope.videoPlayer.setCurrentTime(line.time)
    $scope.$digest()

  $scope.nextLineTimeout = null
  $scope.volumeInterval = null
  $scope.clearVolumeInterval = ->
    clearInterval($scope.volumeInterval)
    $scope.volumeInterval = null
    $scope.videoPlayer.setVolume(GameConfig.volumeMax)

  $scope.clearNextLineTimeout = ->
    $scope.clearVolumeInterval()
    clearTimeout($scope.nextLineTimeout) 
    $scope.nextLineTimeout = null

  $scope.pauseOnNonFinishedLine = ->
    startVolume = GameConfig.volumeMax

    volumeDown = ->
      startVolume -=2
      if startVolume > 0
        $scope.videoPlayer.setVolume(startVolume)
      else
        $scope.clearVolumeInterval()

    pauseABitLater = ->
      if not $scope.currentLine.isMatchingOrignal()
        $scope.videoPlayer.pause()

    if not $scope.nextLineTimeout
      $scope.volumeInterval = setInterval(volumeDown, 50)
      $scope.nextLineTimeout = setTimeout(pauseABitLater, 2500)

  bindPlayPause = ->
    $(document).keydown (e) ->
      $scope.togglePlayer() if Key.isEnter(e.keyCode)

  unbindKeyDownKeyPress = ->
    $(document).unbind('keypress')
    $(document).unbind('keydown')
    bindPlayPause()

  bindKeyDownKeyPress = ->
    $(document).keypress (event) ->
      return false if Key.isSpecial(event.keyCode) # firefox accepts keyCode, chrome which and keyCode

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

  onClickOutsidePlayer = (event) ->
    targetElInsideTranscriptPlayer = $(event.target).parents('#transcript-player').length == 1

    $scope.pause() if !targetElInsideTranscriptPlayer && !$(event.target).is '#transcript-player'

  $scope.togglePlayer = ->
    if $scope.currentState == GameStates.paused
      $scope.play()
    else
      $scope.pause()

  # As a workaround to make it possible to play the current paused line, it starts from the beginning.
  $scope.play = ->
    $scope.clearNextLineTimeout()
    $scope.currentState = GameStates.playing
    bindKeyDownKeyPress()

    if $scope.currentLine.isMatchingOrignal()
      $scope.videoPlayer.play()
    else
      line = $scope.currentLine
      $scope.videoPlayer.setCurrentTime(line.time)

    if !$scope.$$phase
      $scope.$digest()

  $scope.pause = ->
    $scope.currentState = GameStates.paused
    unbindKeyDownKeyPress()
    $scope.clearNextLineTimeout()
    $scope.videoPlayer.pause()
    $scope.$digest()

  $scope.selectGameLevel = (level)->
    $scope.level = level
    $scope.currentState = GameStates.loading
    $scope.videoPlayer.pause()
    $scope.videoPlayer.setCurrentTime(0)

  window.scope = $scope
