LApp.decoreateWithBlanks = (transcript) ->

  NO_MATCH = "there_was_no_word_matching_criteria"
  SPECIAL_CHARS = /[",.\(\)\[\]:;\|\?]/g

  getRandomInt = (min, max) ->
    Math.floor Math.random() * (max - min) + min

  _cutRandomWord = (text) ->
    return NO_MATCH if text.length is 0

    anyWordWithAphostrophe = /\w+('|`|’)\w?/g

    filteredWords = _.filter(text.replace(SPECIAL_CHARS, "").replace(anyWordWithAphostrophe, "").split(" "), (e) ->
      e.length > 3
    )

    randomNumber = getRandomInt(0, filteredWords.length)

    filteredWords[randomNumber] or NO_MATCH

  _generateNew = (transcript) ->
    _.map transcript, (line) ->

      removedWord = _cutRandomWord(line.text)

      if removedWord is NO_MATCH
        line.textWithBlanks = line.text
      else
        index = line.text.indexOf(removedWord)
        line.removedWordsCollection.push(new LApp.RemovedWord(removedWord, index))
        line.textWithBlanks = line.text.replace(
          new RegExp(removedWord), Array(removedWord.length + 1).join(".")
        )

      line

  _generateNew transcript
