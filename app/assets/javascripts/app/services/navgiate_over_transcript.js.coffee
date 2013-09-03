LApp.navigateOverTranscript = ($scope, transcriptFactory) ->
  nav = {}
  nav.lineDown = ->
    $scope.clearNextLineTimeout()
    if $scope.currentLine.isMatchingOrignal()
      line = transcriptFactory.getNext($scope.currentLine)
      $scope.setCurrentLine line

  nav.lineUp = ->
    $scope.clearNextLineTimeout()
    line = transcriptFactory.getPrev($scope.currentLine)
    $scope.setCurrentLine line

  nav
