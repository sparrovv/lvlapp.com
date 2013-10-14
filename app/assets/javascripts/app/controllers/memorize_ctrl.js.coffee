LApp.controller "MemorizeCtrl", ($scope, $http, PhrasesCollection, FlashCardsFactory, SM2Mod) ->
  $scope.flashCardObj = FlashCardsFactory

  FlashCardsFactory.init(PhrasesCollection.phrases)
  $scope.flashCard = FlashCardsFactory.next()
  $scope.state = 'answerHidden'

  $scope.showAnswer = ->
    $scope.state = 'answerShowed'

  $scope.rateAnswer = (scoreName) ->
    # assign score to flashjcard
    sm2 = SM2Mod.calculate(
      scoreMap(scoreName),
      $scope.flashCard.prevInterval(),
      $scope.flashCard.easinessFactor)

    $scope.flashCard.nextRepetitionDate = sm2.nextRepetitionDate
    $scope.flashCard.interval = sm2.interval
    $scope.flashCard.easinessFactor = sm2.easinessFactor
    $scope.flashCard.setReadyToUpdate()

    $scope.flashCard = FlashCardsFactory.next()
    $scope.state = 'answerHidden'

  $scope.saveAndExit = ->
    data = FlashCardsFactory.readyToUpdateAttrs()
    console.log data
    unless data.length > 1
      console.log 'no data'
      return 

    $http.post('/phrases/sm2_update', {phrases_sm2: data}).
      success (data, status, headers, config) ->
        FlashCardsFactory.updateSent()

  window.scope = $scope

  scoreMap = (scoreNmae)->
    map =
      'again': 1
      'hard': 2
      'good': 3
      'easy': 4

    map[scoreNmae]
