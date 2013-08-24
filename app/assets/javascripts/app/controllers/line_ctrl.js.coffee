LApp.phrases = []

LApp.controller "LineCtrl", ($scope, transcriptFactory) ->
  $scope.lookUpInDict = (e) ->
    LApp.PhraseCollection.create(e.word)

class LApp.PhraseCollection
  @create: (name)->
    foo = new LApp.Phrase(name)
    LApp.phrases.push(foo)

class LApp.Phrase
  constructor: (@name) ->

