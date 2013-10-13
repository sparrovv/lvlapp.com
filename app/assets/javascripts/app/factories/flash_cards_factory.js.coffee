class FlashCardAnswer
  constructor: (@translation, @definition, @examples, @related) ->

class FlashCard
  constructor: (@id, @question, @answer) ->
    @scores = []

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
      answer = new FlashCardAnswer(phrase.translation, phrase.definition, phrase.examples, phrase.related)
      f.flashCards.push new FlashCard(phrase.id, phrase.name, answer)

  f.flashCards = []

  f.size = ->
    f.flashCards.length

  f.next = ->
    randomIndex = f._getRandom(0, f.size())
    f.flashCards[randomIndex]

  f._getRandom = (min, max) ->
    Math.floor(Math.random() * (max - min) + min)

  f
