LApp.factory "blanksHelper", (GameConfig) ->
  obj = {}

  obj.NO_MATCH = "there_was_no_word_matching_criteria"
  obj.SPECIAL_CHARS = /[<>",.\(\)\[\]:;\|\?\!\*]/g
  obj.ANY_WORD_WITH_APOSTROPHE = /(\w+('|`|’)\w?)|(^|\s)'\w+/g
  obj.SOUNDS = /\b\w*(\w)\1{2,}\w*\b/g
  obj.BLANK_CHAR = GameConfig.blankChar

  obj.getRandomInt = (min, max) ->
    Math.floor Math.random() * (max - min) + min

  obj.filterOutWeirdWords = (text) ->
    text.
      replace(obj.SPECIAL_CHARS, "").
      replace(obj.ANY_WORD_WITH_APOSTROPHE, "").
      replace(obj.SOUNDS, "").
      replace(/(^\s)|\s$/g, ''). #remove trailling white spaces
      replace(/\s+/, ' '). #replace " "+ with " "
      split(" ")

  obj.cutRandomWord = (text) ->
    return obj.NO_MATCH if text.length is 0

    filteredWords = _.filter(obj.filterOutWeirdWords(text), (e) ->
      e.length > 3
    )

    randomNumber = obj.getRandomInt(0, filteredWords.length)

    filteredWords[randomNumber] or obj.NO_MATCH

  obj
