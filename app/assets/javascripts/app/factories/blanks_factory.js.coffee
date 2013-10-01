LApp.factory "karaokeGen", ->
  f = {}

  f.generate = (transcript) ->
    _.map transcript, (line) ->
      line.textWithBlanks = line.text
      line
  f


LApp.factory "blanksFactory", (karaokeGen)->
  f = {}

  f.generateBlanks = (level, decoratedTranscript) ->
    transcript = []

    if level is 'normal'
      transcript = new LApp.decoreateWithBlanks(decoratedTranscript)

    if level is 'karaoke'
      transcript = karaokeGen.generate(decoratedTranscript)

    transcript

  f
