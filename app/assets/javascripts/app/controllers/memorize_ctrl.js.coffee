LApp.controller "MemorizeCtrl", ($scope, PhrasesCollection, FlashCardsFactory) ->
  $scope.flashCardObj = FlashCardsFactory

  FlashCardsFactory.init(PhrasesCollection.phrases)
  $scope.flashCard = FlashCardsFactory.next()
  $scope.state = 'answerHidden'

  $scope.showAnswer = ->
    $scope.state = 'answerShowed'

  $scope.rateAnswer = (scoreName) ->
    # assign score to flashjcard
    $scope.flashCard.addScore(scoreName)
    #
    $scope.flashCard = FlashCardsFactory.next()
    $scope.state = 'answerHidden'

  $scope.saveAndExit = ->
    console.log 'noop save and exit'

  window.scope = $scope


