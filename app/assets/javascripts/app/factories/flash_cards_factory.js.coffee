class FlashCardAnswer
  constructor: (@translation, @definition, @examples, @related) ->

class FlashCard
  constructor: (@id, @question, @answer, @interval, @nextRepetitionDate, @easinessFactor) ->
    @scores = []
    @readyToUpdate = false


  setReadyToUpdate: ->
    @readyToUpdate = true

  unsetReadyToUpdate: ->
    @readyToUpdate = false

  repetitionDate: ->
    if @nextRepetitionDate
      new Date(@nextRepetitionDate)
    else
      new Date()

  prevInterval: ->
    @interval

LApp.factory "FlashCardsFactory", (blanksHelper) ->
  f = {}

  f.init = (phrases) ->
    _.each phrases, (phrase) ->
      answer = new FlashCardAnswer(phrase.translation, phrase.definition, phrase.examples, phrase.related)
      interval = phrase.interval
      easinessFactor = phrase.easiness_factor
      nextRepetitionDate = phrase.repetition_date_js

      f.flashCards.push new FlashCard(phrase.id, phrase.name, answer, interval, nextRepetitionDate, easinessFactor)

    f.forRepetition = f.generateForRepetition()
    console.log f.forRepetition


  f.flashCards = []
  f.forRepetition = []

  f.generateForRepetition = ->
    actualDate = new Date()
    endOfDayDate = new Date(
      actualDate.getFullYear() ,actualDate.getMonth() ,actualDate.getDate() ,23,59,59
    )

    f.forRepetition = _.filter(f.sortedFlashCardsByDate(), (fc) ->

      console.log fc.repetitionDate()

      fc.repetitionDate() <= endOfDayDate
    )

  f.size = ->
    f.flashCards.length

  f.sortedFlashCardsByDate = ->
    _.sortBy f.flashCards, (fCard) ->
      fCard.repetitionDate

  f.next = ->
    f.forRepetition.pop()

  f.readyToUpdateAttrs = ->
    readyToU = _.select f.flashCards, (fc) ->
      fc.readyToUpdate == true

    _.map readyToU, (fc) ->
      'id': fc.id
      'interval': fc.interval
      'easiness_factor': fc.easinessFactor
      'repetition_date': fc.nextRepetitionDate

  f.updateSent = ->
    _.each f.flashCards, (fc) ->
      fc.unsetReadyToUpdate()

  f.addToReadyToUpdate = (phrase) ->
    phrase.readyToUpdate

  f._getRandom = (min, max) ->
    Math.floor(Math.random() * (max - min) + min)

  f
