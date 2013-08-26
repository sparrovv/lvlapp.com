LApp.factory "transcriptFactory", (audioVideo)->
  factory = {}
  decoratedTranscript = undefined

  decoratedTranscript = _.map(audioVideo.rawTranscript, (line, index) ->
    new LApp.TranscriptLine(line.time, line.text, index)
  )

  factory.transcript = new LApp.decoreateWithBlanks(decoratedTranscript)

  factory.numberOfBlanks = ->
    size = 0

    _.each factory.transcript, (line) ->
      size += line.removedWordsCollection.length

    size

  factory.firstWithBlanks = ->
    _.find factory.transcript, (line) ->
      line.hasBlanks() is true

  factory.getPrev = (line) ->
    factory.transcript[line.index - 1] or line

  factory.getNext = (line) ->
    factory.transcript[line.index + 1] or line

  factory
