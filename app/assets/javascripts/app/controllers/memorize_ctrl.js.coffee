LApp.controller "MemorizeCtrl", ($scope, $http, PhrasesCollection, FlashCards, SM2Mod) ->
  $scope.flashCardObj = FlashCards

  FlashCards.init(PhrasesCollection.phrases)
  $scope.flashCard = FlashCards.next()
  $scope.state = 'answerHidden'

  $scope.showAnswer = ->
    $scope.state = 'answerShowed'

  $scope.rateAnswer = (scoreName) ->
    FlashCards.updateSM2Results($scope.flashCard, scoreMap(scoreName))
    $scope.flashCard = FlashCards.next()
    $scope.state = 'answerHidden'

  $scope.saveAndExit = ->
    data = FlashCards.readyToUpdateAttrs()
    console.log data

    unless data.length > 0
      console.log 'no data'
      return false

    $http.post('/phrases/sm2_update', {phrases_sm2: data}).
      success (data, status, headers, config) ->
        FlashCards.updateSent()

  window.scope = $scope

  scoreMap = (scoreNmae)->
    map =
      'again': 1
      'hard': 2
      'good': 3
      'easy': 4

    map[scoreNmae]
