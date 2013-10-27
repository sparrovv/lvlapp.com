class FlashCardAnswer
  constructor: (@translation, @sentence, @definition, @examples, @related) ->

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

LApp.service "FlashCards",
  class FlashCards
    constructor:(@SM2Mod) ->
      @flashCards = []
      @forRepetition = []

    init: (phrases) ->
      self = @
      _.each phrases, (phrase) ->
        answer = new FlashCardAnswer(phrase.translation, phrase.sentence, phrase.definition, phrase.examples, phrase.related)
        interval = phrase.interval
        easinessFactor = phrase.easiness_factor
        nextRepetitionDate = phrase.repetition_date_js

        self.flashCards.push(new FlashCard(phrase.id, phrase.name, answer, interval, nextRepetitionDate, easinessFactor))

      @forRepetition = @generateForRepetition()

    updateSM2Results: (flashCard, score) ->
      sm2 = @SM2Mod.calculate(
        score,
        flashCard.prevInterval(),
        flashCard.easinessFactor)

      flashCard.nextRepetitionDate = sm2.nextRepetitionDate
      flashCard.interval = sm2.interval
      flashCard.easinessFactor = sm2.easinessFactor
      flashCard.setReadyToUpdate()

    generateForRepetition: ->
      actualDate = new Date()
      endOfDayDate = new Date(
        actualDate.getFullYear() ,actualDate.getMonth() ,actualDate.getDate() ,23,59,59
      )

      _.filter @sortedFlashCardsByDate(), (fc) ->
        fc.repetitionDate() <= endOfDayDate

    sortedFlashCardsByDate: ->
      _.sortBy @flashCards, (fc) ->
        fc.repetitionDate

    next: ->
      @forRepetition.pop()

    readyToUpdateAttrs: ->
      readyToUpdate = _.select @flashCards, (fc) ->
        fc.readyToUpdate == true

      _.map readyToUpdate, (fc) ->
        'id': fc.id
        'interval': fc.interval
        'easiness_factor': fc.easinessFactor
        'repetition_date': fc.nextRepetitionDate

    updateSent: ->
      _.each @flashCards, (fc) ->
        fc.unsetReadyToUpdate()
