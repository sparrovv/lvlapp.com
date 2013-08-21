LApp.navigateOverTranscript = ($scope, transcriptFactory) ->
  nav = {}
  nav.lineDown = ->
    line = transcriptFactory.getNext($scope.currentLine)
    $scope.setCurrentLine line

  nav.lineUp = ->
    line = transcriptFactory.getPrev($scope.currentLine)
    $scope.setCurrentLine line

  nav
