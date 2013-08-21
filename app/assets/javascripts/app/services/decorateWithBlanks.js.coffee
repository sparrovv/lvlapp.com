LApp.decoreateWithBlanks = (transcript) ->
  getRandomInt = (min, max) ->
    Math.floor Math.random() * (max - min) + min

  _cutRandomWord = (text) ->
    filteredWords = _.filter(text.replace(/[,.\(\)\[\]:;\|\?]/g, "").split(" "), (e) ->
      e.length > 3
    )
    randomNumber = getRandomInt(0, filteredWords.length)
    filteredWords[randomNumber] or "there_was_no_word_matching_criteria"

  _generateNew = (transcript) ->
    _.map transcript, (line) ->
      removedWord = _cutRandomWord(line.text)
      line.removedWords.push removedWord
      line.textWithBlanks = line.text.replace(new RegExp(removedWord), Array(removedWord.length + 1).join("."))
      line

  _generateNew transcript
