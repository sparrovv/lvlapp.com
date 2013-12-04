LApp.controller "MemorizeCtrl", ($scope, $http, PhrasesCollection, FlashCards, SM2Mod) ->
  $scope.flashCardObj = FlashCards
  FlashCards.init(PhrasesCollection.phrases)
  $scope.flashCard = FlashCards.next()

  _getSoonestRepetitionDate = ->
    new Date(FlashCards.soonestRepetitionDate()).toDateString()

  if $scope.flashCard
    $scope.state = 'answerHidden'
  else
    $scope.state = 'nothingToRepeat'
    $scope.soonestRepetitionDate = _getSoonestRepetitionDate()

  $scope.showAnswer = ->
    $scope.state = 'answerShowed'

  $scope.rateAnswer = (scoreName) ->
    FlashCards.updateSM2Results($scope.flashCard, scoreMap(scoreName))
    nextWord = FlashCards.next()
    if nextWord
      $scope.flashCard = nextWord
      $scope.state = 'answerHidden'
    else
      $scope.state = 'endOfRepetition'
      $scope.soonestRepetitionDate = _getSoonestRepetitionDate()
      $scope.save()

  $scope.save = (callback) ->
    data = FlashCards.readyToUpdateAttrs()

    unless data.length > 0
      console.log 'no data'
      return false

    $http.post('/phrases/sm2_update', {phrases_sm2: data}).
      success (data, status, headers, config) ->
        FlashCards.updateSent()
        callback() if callback

  $scope.saveAndExit = ->
    url = '/memorize/index'
    exit = ->
      window.location = url

    $scope.save(exit)

  window.scope = $scope

  scoreMap = (scoreNmae)->
    map =
      'again': 1
      'hard': 2
      'good': 3
      'easy': 4

    map[scoreNmae]
