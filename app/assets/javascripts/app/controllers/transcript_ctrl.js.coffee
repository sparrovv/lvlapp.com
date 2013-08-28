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
    $scope.currentLineTopPosition = start - ($scope.currentLine.index * 31)
    LApp.highlightService $scope.currentLine

  $scope.setCurrentLine = (line) ->
    $scope.currentLine = line
    $scope.videoPlayer.currentTime(line.time).play()
    $scope.$digest()

  $scope.$on "newLine", (event, newLine) ->
    if $scope.currentLine.isMatchingOrignal()
      $scope.currentLine = newLine
      $scope.$digest()
    else
      pauseABitLater = ->
        $scope.videoPlayer.pause()
      setTimeout(pauseABitLater, 700)

  $(document).keypress (event) ->
    letter = String.fromCharCode(event.which)
    $scope.spellChecker.nextLetter letter

  $(document).keydown (e) ->
    $scope.navigator.lineDown()  if e.keyCode is 40
    $scope.navigator.lineUp()  if e.keyCode is 38
    $scope.spellChecker.skipWord()  if e.keyCode is 9
    if e.keyCode is 8
      e.preventDefault()
      currentLineWithBlanks = transcriptFactory.firstWithBlanks()
      currentLineWithBlanks.removeLastFromBuffer() 

      $scope.$apply()

      return false

    false  if e.keyCode is 40 or e.keyCode is 38 or e.keyCode is 9 or e.keyCode is 8

  window.scope = $scope
