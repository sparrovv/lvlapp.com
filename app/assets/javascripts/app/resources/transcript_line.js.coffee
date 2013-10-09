String.prototype.replaceAt = (index, character) ->
  this.substr(0, index) + character + this.substr(index+character.length)

String.prototype.replaceAtWithLength = (index, character, length) ->
  this.substr(0, index) + character + this.substr(index+length)

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
    @textWithBlanks = ''

  htmlId: ->
    "#" + (@time.toFixed(2).replace('.','') )

  words: ->
    @guessedWithBlanks().split(" ")

  removeLastFromBuffer: ->
    @currentLettersBuffer = @currentLettersBuffer.slice(0,-1)

  decorateLettersWithErrors: (original, buffer) ->
    original = original.toLowerCase()
    decoratedBuffer = _.map buffer.split(''), (letter, index) ->
      if letter.toLowerCase() is original[index]
        "<correct>#{letter}</correct>"
      else
        "<fault>#{letter}</fault>"

    decoratedBuffer.join('')

  guessedWithBlanks: ->
    missingWordObj = @getMissingWordObj(@nextMissingWord())

    if missingWordObj
      decoratedBuffer = @decorateLettersWithErrors(missingWordObj.word, @currentLettersBuffer)

      @textWithBlanks.replaceAtWithLength(missingWordObj.index, decoratedBuffer, @currentLettersBuffer.length)
    else
      @textWithBlanks

  isMatchingOrignal: ->
    @hasBlanks() is false

  removedWords: ->
    sortedWords =_.sortBy @removedWordsCollection, (removedWord)->
      removedWord.index
    _.map sortedWords, (removedWord)->
      removedWord.word

  hasBlanks: ->
    @removedWords().join('') isnt @guessedWords.join('')

  firstBlankCharacter: ->
    regexp = new RegExp("^" + @currentLettersBuffer, "g")
    @nextMissingWord().replace(regexp, "")[0]

  getMissingWordObj: (word) ->
    leftWords = @removedWordsCollection.slice(@guessedWords.length)

    _.find leftWords, (w)->
      w.word == word

  clearBuffer: ->
    @currentLettersBuffer = ''

  guess: (letter) ->
    @currentLettersBuffer += letter

    if @_isBufferEqlToTheNextMissingWord()
      word = @nextMissingWord()
      missingWordObj = @getMissingWordObj(word)
      @guessedWords.push(word)
      @textWithBlanks = @textWithBlanks.replaceAt(missingWordObj.index, missingWordObj.word)
      @clearBuffer()
      {correctLetter: true, correctWord: true}
    else
      {correctLetter: @_isCorrectLetter(letter), correctWord: false}

  nextMissingWord: ->
    index = @guessedWords.length
    @removedWords()[index]

  _isBufferEqlToTheNextMissingWord: () ->
    @nextMissingWord().toLowerCase() is @currentLettersBuffer.toLowerCase()

  _isCorrectLetter: (letter) ->
    size = @currentLettersBuffer.length
    @nextMissingWord().toLowerCase()[size-1] is letter.toLowerCase()
