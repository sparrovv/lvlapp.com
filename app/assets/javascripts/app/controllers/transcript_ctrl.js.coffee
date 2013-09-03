LApp.controller "TranscriptCtrl", ($scope, transcriptFactory, Stats) ->
  $scope.transcript = transcriptFactory.transcript
  $scope.currentLine = $scope.transcript[0]

  $scope.spellChecker = new LApp.spellCheckService(transcriptFactory, $scope, Stats)

  Stats.setBlanks(transcriptFactory.numberOfBlanks())
  # @todo move to factory/service... maybe
  $scope.transcriptTimeRange = LApp.getTimeRange($scope.transcript)
  $scope.videoPlayer = videojs("example_video_1")
  $scope.videoPlayer.on "timeupdate", ->
    LApp.locateCurrentLine @currentTime(), $scope

  $scope.navigator = LApp.navigateOverTranscript($scope, transcriptFactory)
  $scope.currentLineTopPosition = 30
  $scope.$watch "currentLine", ->
    start = 30
    lineHeight = 32.5
    $scope.currentLineTopPosition = start - ($scope.currentLine.index * lineHeight)
    LApp.highlightService $scope.currentLine

  $scope.setCurrentLine = (line) ->
    $scope.currentLine = line
    $scope.videoPlayer.currentTime(line.time).play()
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
    letter = String.fromCharCode(event.which)
    $scope.spellChecker.nextLetter letter

  $(document).click (event) ->
    targetElInsideTranscriptPlayer = $(event.target).parents('#transcript-player').length == 1
    $scope.pause() if not targetElInsideTranscriptPlayer

  $(document).keydown (e) ->
    $scope.navigator.lineDown()    if e.keyCode is 40 # down
    $scope.navigator.lineUp()      if e.keyCode is 38 # up
    $scope.spellChecker.skipWord() if e.keyCode is 9  # tab

    if e.keyCode is 8 # backspace
      e.preventDefault()
      currentLineWithBlanks = transcriptFactory.firstWithBlanks()
      currentLineWithBlanks.removeLastFromBuffer()

      $scope.$apply()

    false  if e.keyCode is 40 or e.keyCode is 38 or e.keyCode is 9 or e.keyCode is 8

  $scope.playerNextState = 'Play'
  $scope.togglePlayer = ->
    if $scope.videoPlayer.paused()
      $scope.play()
    else
      $scope.pause()

  $scope.play = ->
    $scope.playerNextState = 'Pause'
    if $scope.currentLine.isMatchingOrignal()
      $scope.videoPlayer.play()

  $scope.pause = ->
    $scope.videoPlayer.pause()
    $scope.playerNextState = 'Play'
    $scope.$digest()

  window.scope = $scope
