LApp.factory "transcriptFactory", (audioVideo, blanksFactory)->
  factory = {}

  factory.transcript = decoratedTranscript = _.map audioVideo.rawTranscript, (line, index) ->
    new LApp.TranscriptLine(line.time, line.text, index+1)

  # put a null transcript line at the beginning of the transcript
  factory.transcript.unshift(new LApp.TranscriptLine(0, '', 0))

  factory.setupBlanks = (level)->
    factory.transcript = blanksFactory.generateBlanks(level, factory.transcript)

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

  factory.isLastLine = (line) ->
    (line.index + 1) == factory.transcript.length

  factory
