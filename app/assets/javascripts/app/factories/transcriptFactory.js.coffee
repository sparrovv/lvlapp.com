LApp.factory "transcriptFactory", (audioVideo)->
  factory = {}
  decoratedTranscript = undefined

  decoratedTranscript = _.map(audioVideo.rawTranscript, (line, index) ->
    new LApp.TranscriptLine(line.time, line.text, index+1)
  )

  factory.transcript = new LApp.decoreateWithBlanks(decoratedTranscript)
  # put a null transcript line at the beginning of the transcript
  factory.transcript.unshift(new LApp.TranscriptLine(0, '', 0))

  factory.numberOfBlanks = ->
    size = 0
    _.each factory.transcript, (line) ->
      if line.hasBlanks() is true
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
