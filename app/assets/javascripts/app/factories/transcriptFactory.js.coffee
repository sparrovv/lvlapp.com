LApp.factory "transcriptFactory", ->
  factory = {}
  decoratedTranscript = undefined

  # transcipt is set as a global var
  decoratedTranscript = _.map(rawTranscript, (line, index) ->
    new LApp.TranscriptLine(line.time, line.text, index)
  )
  factory.transcript = new LApp.decoreateWithBlanks(decoratedTranscript)
  factory.firstWithBlanks = ->
    _.find factory.transcript, (line) ->
      line.hasBlanks() is true

  factory.getPrev = (line) ->
    factory.transcript[line.index - 1] or line

  factory.getNext = (line) ->
    factory.transcript[line.index + 1] or line

  factory
