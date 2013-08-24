LApp.controller "TranscriptCtrl", ($scope, transcriptFactory) ->
  $scope.currentLine = new LApp.NullTranscriptLine()
  $scope.transcript = transcriptFactory.transcript
  $scope.spellChecker = new LApp.spellCheckService(transcriptFactory, $scope)

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
    if line.isMatchingOrignal()
      $scope.currentLine = line
      $scope.videoPlayer.currentTime(line.time).play()
      $scope.$digest()

  $scope.$on "newLine", (event, newLine) ->
    if $scope.currentLine.isMatchingOrignal()
      $scope.currentLine = newLine
      $scope.$digest()
    else
      $scope.videoPlayer.pause() # @todo put into timeout, cause there are a lot of time mismatches. .....

  $(document).keypress (event) ->
    letter = String.fromCharCode(event.which)
    $scope.spellChecker.nextLetter letter

  $(document).keydown (e) ->
    $scope.navigator.lineDown()  if e.keyCode is 40
    $scope.navigator.lineUp()  if e.keyCode is 38
    $scope.spellChecker.skipWord()  if e.keyCode is 9
    if e.keyCode is 8
      e.preventDefault()

      $scope.currentLine.removeLastFromBuffer() 
      $scope.$apply()

      return false

    false  if e.keyCode is 40 or e.keyCode is 38 or e.keyCode is 9 or e.keyCode is 8

  window.scope = $scope
