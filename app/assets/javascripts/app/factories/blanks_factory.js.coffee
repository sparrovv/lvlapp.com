LApp.factory "normalLevelBlanksGenerator", (blanksHelper) ->
  generate: (transcript) ->
    _.map transcript, (line) ->
      line.initTemporaryState()

      blanksHelper.decorateWithBlank(line)

      line

LApp.factory "easyLevelBlanksGenerator", (blanksHelper) ->
  generate: (transcript) ->
    fullLineCounter = []

    _.map transcript, (line) ->
      line.initTemporaryState()
      line.textWithBlanks = line.text
      randomDivisor = [2, 3, 5][blanksHelper.getRandomInt(0,3)]

      if line.index % randomDivisor == 0
        blanksHelper.decorateWithBlank(line)
        fullLineCounter = []
      else
        fullLineCounter.push 'foo'
        if fullLineCounter.length == 3
          fullLineCounter = []
          blanksHelper.decorateWithBlank(line)

      line

LApp.factory "karaokeLevelBlanksGenerator", ->
  generate: (transcript) ->
    _.map transcript, (line) ->
      line.initTemporaryState()
      line.textWithBlanks = line.text
      line

LApp.factory "hardLevelBlanksGenerator", (blanksHelper) ->
  lineObfuscator = (line) ->
    line.initTemporaryState()
    line.textWithBlanks = line.text

    preFilteredWords = blanksHelper.filterOutWeirdWords(line.text)

    filteredWords = _.filter preFilteredWords, (word) ->
      word.length > 1

    _.each filteredWords, (removedWord) ->
      index = line.textWithBlanks.indexOf(removedWord)
      line.removedWordsCollection.push(new LApp.RemovedWord(removedWord, index))
      line.textWithBlanks = line.textWithBlanks.replace(
        new RegExp(removedWord), Array(removedWord.length + 1).join(blanksHelper.BLANK_CHAR)
      )

    line

  generate: (transcript) ->
    _.map transcript, (line) ->
      lineObfuscator(line)

LApp.factory "blanksFactory", (karaokeLevelBlanksGenerator, normalLevelBlanksGenerator, hardLevelBlanksGenerator, easyLevelBlanksGenerator)->
  generateBlanks: (level, decoratedTranscript) ->
    transcript = []

    if level is 'easy'
      transcript = easyLevelBlanksGenerator.generate(decoratedTranscript)

    if level is 'normal'
      transcript = normalLevelBlanksGenerator.generate(decoratedTranscript)

    if level is 'karaoke'
      transcript = karaokeLevelBlanksGenerator.generate(decoratedTranscript)

    if level is 'hard'
      transcript = hardLevelBlanksGenerator.generate(decoratedTranscript)

    transcript
