LApp.decoreateWithBlanks = (transcript) ->

  NO_MATCH = "there_was_no_word_matching_criteria"

  getRandomInt = (min, max) ->
    Math.floor Math.random() * (max - min) + min

  _cutRandomWord = (text) ->
    anyWordWithAphostrophe = /\w+'\w?/g
    specialChars = /[,.\(\)\[\]:;\|\?]/g

    filteredWords = _.filter(text.replace(specialChars, "").replace(anyWordWithAphostrophe, "").split(" "), (e) ->
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
        line.removedWords.push removedWord
        line.textWithBlanks = line.text.replace(
          new RegExp(removedWord), Array(removedWord.length + 1).join(".")
        )

      line

  _generateNew transcript
