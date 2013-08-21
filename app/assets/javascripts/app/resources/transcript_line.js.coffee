class LApp.NullTranscriptLine
  constructor: (time, text, index) ->
    @index = 0

  isMatchingOrignal: ->
    true

  htmlId: ->
    "ThereIsNoSpoon"

class LApp.TranscriptLine

  constructor: (time, text, index) ->
    @time = parseFloat(time)
    @text = text
    @index = index
    @removedWords = []
    @guessed = []
    @guessedWords = []

  htmlId: ->
    "#" + (@time * 1000)

  words: ->
    @guessedWithBlanks().split " "

  guessedWithBlanks: ->
    word = @guessed.join("")
    @textWithBlanks.replace Array(word.length + 1).join("."), word

  isMatchingOrignal: ->
    @hasBlanks() is false

  hasBlanks: ->
    @removedWords.join("") isnt @guessed.join("")

  firstBlankCharacter: ->
    regexp = new RegExp("^" + @guessed.join(""), "g")
    @removedWords.join("").replace(regexp, "")[0]

  addGuessed: (letter) ->
    self = this
    @guessed.push letter
    diff = _.difference(@removedWords, @guessedWords)
    regexp = new RegExp("^" + @guessedWords.join(""), "gi")
    left = @guessed.join("").replace(regexp, "")
    _.each diff, (word) ->
      r = new RegExp("^" + word, "gi")
      if left.match(r)
        self.guessedWords.push word
        left = left.replace(r, "")


  guess: (letter) ->
    if letter.toLowerCase() is @firstBlankCharacter().toLowerCase()
      @addGuessed @firstBlankCharacter()
      true
    else
      false

  nextWord: ->
    index = @guessedWords.length
    @removedWords[index]
