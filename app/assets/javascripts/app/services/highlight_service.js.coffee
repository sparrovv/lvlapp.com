LApp.highlightService = (line) ->
  $("p.highlight").removeClass "highlight"
  htmlLine = $("[data-line-id=" + line.htmlId() + "]")
  htmlLine.addClass "highlight"
