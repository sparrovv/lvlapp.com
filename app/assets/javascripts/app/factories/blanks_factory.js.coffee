LApp.factory "normalLevelBlanksGenerator", (blanksHelper) ->
  generate: (transcript) ->
    _.map transcript, (line) ->
      line.initTemporaryState()

      removedWord = blanksHelper.cutRandomWord(line.text)

      if removedWord is blanksHelper.NO_MATCH
        line.textWithBlanks = line.text
      else
        index = line.text.indexOf(removedWord)
        line.removedWordsCollection.push(new LApp.RemovedWord(removedWord, index))
        line.textWithBlanks = line.text.replace(
          new RegExp(removedWord), Array(removedWord.length + 1).join(blanksHelper.BLANK_CHAR)
        )

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

    preFilteredWords = line.text.
      replace(blanksHelper.SPECIAL_CHARS, "").
      replace(blanksHelper.ANY_WORD_WITH_APHOSTROPHE, "").
      split(" ")

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

LApp.factory "blanksFactory", (karaokeLevelBlanksGenerator, normalLevelBlanksGenerator, hardLevelBlanksGenerator)->
  generateBlanks: (level, decoratedTranscript) ->
    transcript = []

    if level is 'normal'
      transcript = normalLevelBlanksGenerator.generate(decoratedTranscript)

    if level is 'karaoke'
      transcript = karaokeLevelBlanksGenerator.generate(decoratedTranscript)

    if level is 'hard'
      transcript = hardLevelBlanksGenerator.generate(decoratedTranscript)

    transcript
