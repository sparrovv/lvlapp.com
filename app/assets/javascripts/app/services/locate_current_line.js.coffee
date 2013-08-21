LApp.locateCurrentLine = (currentTime, $scope) ->
  _.each $scope.transcriptTimeRange, (range) ->
    if range.range[0] < currentTime and range.range[1] > currentTime
      line = range.line
      $scope.$emit "newLine", line  unless $scope.currentLine is line

