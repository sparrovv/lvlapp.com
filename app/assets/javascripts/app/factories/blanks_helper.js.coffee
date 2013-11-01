LApp.factory "blanksHelper", (GameConfig) ->
  obj = {}

  obj.NO_MATCH = "there_was_no_word_matching_criteria"
  obj.ANY_WORD_WITH_APOSTROPHE = /(\w{1,}(-|'|`|’|\*)\w{0,})|(^|\s)'\w+/g
  obj.SPECIAL_CHARS = /[<>",.\(\)\[\]:;\|\?\!\*]/g
  obj.SOUNDS = /\b\w*(\w)\1{2,}\w*\b/g
  obj.BLANK_CHAR = GameConfig.blankChar

  obj.decorateWithBlank = (line) ->
    removedWord = obj.cutRandomWord(line.text)

    if removedWord is obj.NO_MATCH
      line.textWithBlanks = line.text
    else
      index = line.text.indexOf(removedWord)
      line.removedWordsCollection.push(new LApp.RemovedWord(removedWord, index))
      line.textWithBlanks = line.text.replace(
        new RegExp(removedWord), Array(removedWord.length + 1).join(obj.BLANK_CHAR)
      )

    line

  obj.getRandomInt = (min, max) ->
    Math.floor Math.random() * (max - min) + min

  obj.filterOutWeirdWords = (text) ->
    text.
      replace(obj.ANY_WORD_WITH_APOSTROPHE, "").
      replace(obj.SPECIAL_CHARS, "").
      replace(obj.SOUNDS, "").
      replace(/(^\s)|\s$/g, ''). #remove trailling white spaces
      replace(/\s+/, ' '). #replace " "+ with " "
      split(" ")

  obj.cutRandomWord = (text) ->
    return obj.NO_MATCH if text.length is 0

    filteredWords = _.filter obj.filterOutWeirdWords(text), (e) ->
      e.length > 3

    sortedWords = _.sortBy filteredWords, (e) ->
      -1*e.length

    if sortedWords.length == 1
      index = 0
    else if sortedWords.length > 6
      index = obj.getRandomInt(0, 3)
    else
      index = obj.getRandomInt(0, 2)

    sortedWords[index] or obj.NO_MATCH

  obj
