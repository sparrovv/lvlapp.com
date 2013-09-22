LApp.controller "TranscriptCtrl", ($scope, transcriptFactory, Stats, Key) ->
  $scope.transcriptFactory = transcriptFactory
  $scope.transcript = transcriptFactory.transcript
  $scope.currentLine = $scope.transcript[0]

  $scope.spellChecker = new LApp.spellCheckService(transcriptFactory, $scope, Stats)

  Stats.setBlanks(transcriptFactory.numberOfBlanks())
  # @todo move to factory/service... maybe
  $scope.transcriptTimeRange = LApp.getTimeRange($scope.transcript)

  # this decorates $scope with videoPlayer
  # there can be some timing issues if ......... tests
  LApp.VideoPlayerFactory.init($scope, window.isYoutubeVideo)

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

  $(document).keypress (event) ->
    return false  if Key.isSpecial(event.which)

    letter = String.fromCharCode(event.which)
    $scope.spellChecker.nextLetter letter

  $(document).click (event) ->
    targetElInsideTranscriptPlayer = $(event.target).parents('#transcript-player').length == 1
    $scope.pause() if not targetElInsideTranscriptPlayer

  $(document).keydown (e) ->
    $scope.navigator.lineDown()    if Key.isKeyDown(e.keyCode)
    $scope.navigator.lineUp()      if Key.isKeyUp(e.keyCode)
    $scope.spellChecker.skipWord() if Key.isTab(e.keyCode)
    $scope.togglePlayer()          if Key.isEnter(e.keyCode)

    if Key.isBackspace(e.keyCode)
      e.preventDefault()
      currentLineWithBlanks = transcriptFactory.firstWithBlanks()
      currentLineWithBlanks.removeLastFromBuffer()

      $scope.$apply()

    return false  if Key.isSpecial(e.keyCode)

  $scope.currentState = 'paused'
  $scope.togglePlayer = ->
    if $scope.currentState == 'paused'
      $scope.play()
    else
      $scope.pause()

  # As a workaround to make it possible to play the current paused line, it starts from the beginning.
  $scope.play = ->
    $scope.currentState = 'playing'

    if $scope.currentLine.isMatchingOrignal()
      $scope.videoPlayer.play()
    else
      line = $scope.currentLine
      $scope.videoPlayer.setCurrentTime(line.time)

    $scope.$digest()

  $scope.pause = ->
    $scope.clearNextLineTimeout()
    $scope.currentState = 'paused'
    $scope.$digest()
    $scope.videoPlayer.pause()

  $scope.onPlayClick = ->
    $scope.play()

  window.scope = $scope
