class FlashCard
  constructor: (@id, @question, @answer, @exmaple) ->
    @scores = []

  fullAnswer: ->
    [@answer,  @exmaple].join('; ')

  addScore: (scoreName) ->
    s = @scoreMap(scoreName)
    @scores.push(s)

  scoreMap: (scoreNmae)->
    map =
      'again': 1
      'hard': 2
      'good': 3
      'easy': 4

    map[scoreNmae]

LApp.factory "FlashCardsFactory", (blanksHelper) ->
  f = {}

  f.init = (phrases) ->
    _.each phrases, (phrase) ->
      f.flashCards.push new FlashCard(phrase.id, phrase.name, phrase.definition, phrase.examples)

  f.flashCards = []

  f.size = ->
    f.flashCards.length

  f.next = ->
    randomIndex = f._getRandom(0, f.size())
    f.flashCards[randomIndex]

  f._getRandom = (min, max) ->
    Math.floor(Math.random() * (max - min) + min)

  f
