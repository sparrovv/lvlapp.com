LApp.locateCurrentLine = (currentTime, $scope) ->
  _.each $scope.transcriptTimeRange, (range) ->
    if range.range[0] < currentTime and range.range[1] > currentTime
      line = range.line

      # Had to introduce this safeguard and global state so it will knew that there was a new line triggered and should ignore it
      if $scope.lineUpOrBeginningPressed
        $scope.lineUpOrBeginningPressed = undefined
        return

      if $scope.currentLine.index != line.index && line.index > $scope.currentLine.index
        $scope.$emit "newLine", line

