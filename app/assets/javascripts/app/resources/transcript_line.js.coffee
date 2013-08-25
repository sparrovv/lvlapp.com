String.prototype.replaceAt = (index, character) ->
  this.substr(0, index) + character + this.substr(index+character.length)

String.prototype.replaceAtWithLength = (index, character, length) ->
  this.substr(0, index) + character + this.substr(index+length)

class LApp.NullTranscriptLine
  constructor: (time, text, index) ->
    @index = 0

  isMatchingOrignal: ->
    true

  htmlId: ->
    "ThereIsNoSpoon"

  removeLastFromBuffer: ->
    true

class LApp.RemovedWord
  constructor: (@word, @index) ->

  length: ->
    @word.length

class LApp.TranscriptLine
  constructor: (time, @text, @index) ->
    @time = parseFloat(time)
    @currentLettersBuffer = ""
    @removedWordsCollection = []
    @guessedWords = []

  htmlId: ->
    "#" + (@time.toFixed(2).replace('.','') )

  words: ->
    @guessedWithBlanks().split(" ")

  removeLastFromBuffer: ->
    @currentLettersBuffer = @currentLettersBuffer.slice(0,-1)

  decorateLettersWithErrors: (original, buffer) ->
    original = original.toLowerCase()
    bar = _.map buffer.split(''), (letter, index) ->
      if letter.toLowerCase() is original[index]
        "<correct>#{letter}</correct>"
      else
        "<fault>#{letter}</fault>"

    bar.join('')

  guessedWithBlanks: ->
    missingWordObj = @getMissingWordObj(@nextMissingWord())

    if missingWordObj
      decoratedWord = @decorateLettersWithErrors(missingWordObj.word, @currentLettersBuffer)

      @textWithBlanks.replaceAtWithLength(missingWordObj.index, decoratedWord, @currentLettersBuffer.length)
    else
      @textWithBlanks

  isMatchingOrignal: ->
    @hasBlanks() is false

  removedWords: ->
    _.map @removedWordsCollection, (removedWord)->
      removedWord.word

  hasBlanks: ->
    @removedWords().join('') isnt @guessedWords.join('')

  firstBlankCharacter: ->
    regexp = new RegExp("^" + @currentLettersBuffer, "g")
    @nextMissingWord().replace(regexp, "")[0]

  getMissingWordObj: (word) ->
    _.find @removedWordsCollection, (w)->
      w.word == word

  addGuessed: (letter) ->
    @currentLettersBuffer += letter

    if @nextMissingWord().toLowerCase() is @currentLettersBuffer.toLowerCase()
      word = @nextMissingWord()
      @guessedWords.push(word)
      missingWordObj = @getMissingWordObj(word)
      @textWithBlanks = @textWithBlanks.replaceAt(missingWordObj.index, missingWordObj.word)
      @clearBuffer()

  clearBuffer: ->
    @currentLettersBuffer = ''

  guess: (letter) ->
    @addGuessed(letter)
    true

  nextMissingWord: ->
    index = @guessedWords.length
    @removedWords()[index]

