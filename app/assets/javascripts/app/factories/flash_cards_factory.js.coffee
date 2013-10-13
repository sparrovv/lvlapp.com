class FlashCardAnswer
  constructor: (@translation, @definition, @examples, @related) ->

class FlashCard
  constructor: (@id, @question, @answer, @interval, @nextRepetitionDate, @easinessFactor) ->
    @scores = []

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
      interval = phrase.repetition_interval
      easinessFactor = phrase.easiness_factor
      nextRepetitionDate = phrase.next_repetition_date

      f.flashCards.push new FlashCard(phrase.id, phrase.name, answer, interval, nextRepetitionDate, easinessFactor)

    f.forRepetition = f.generateForRepetition()
    console.log f.forRepetition


  f.flashCards = []
  f.forRepetition = []

  f.generateForRepetition = ->
    console.log f.sortedFlashCardsByDate()
    dateToday = new Date()
    console.log dateToday.getDate()

    f.forRepetition = _.filter(f.sortedFlashCardsByDate(), (fc) ->
      console.log fc.repetitionDate()
      fc.repetitionDate().getDate() <= dateToday.getDate()
    )

  f.size = ->
    f.flashCards.length

  f.sortedFlashCardsByDate = ->
    _.sortBy f.flashCards, (fCard) ->
      fCard.repetitionDate

  f.next = ->
    f.forRepetition.pop()

    #randomIndex = f._getRandom(0, f.size())
    #f.flashCards[randomIndex]

  f._getRandom = (min, max) ->
    Math.floor(Math.random() * (max - min) + min)

  f
