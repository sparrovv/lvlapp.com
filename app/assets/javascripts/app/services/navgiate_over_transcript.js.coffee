LApp.navigateOverTranscript = ($scope, transcriptFactory) ->
  nav = {}
  nav.lineDown = ->
    if $scope.currentLine.isMatchingOrignal()
      line = transcriptFactory.getNext($scope.currentLine)
      $scope.setCurrentLine line

  nav.lineUp = ->
    line = transcriptFactory.getPrev($scope.currentLine)
    $scope.setCurrentLine line
    $scope.lineUpPressed = line

  nav.beginningOfline = ->
    $scope.setCurrentLine $scope.currentLine

  nav
