LApp.factory "LineTorch", (GameConfig) ->
  highlight: (line, $scope) ->
    $scope.currentLineTopPosition = 
      GameConfig.lineStartPosition - ($scope.currentLine.index * GameConfig.lineHeight)

    $("p.highlight").removeClass "highlight"
    htmlLine = $("[data-line-id=" + line.htmlId() + "]")
    htmlLine.addClass "highlight"
