LApp.controller "VideoInfoCtrl", ($scope, $rootScope, GameStates) ->
  $scope.currentState = GameStates.loading
  $scope.currentVideoTime = 0
  $scope.videoDuration = 0
  $scope.progressValue = 0

  calculateProgress = (currentVideoTime, videoDuration)->
    (parseInt(currentVideoTime) / parseInt(videoDuration)) * 100

  $rootScope.$on 'stateChanged', (event, args) ->
    $scope.currentState = args.state
    $scope.$digest() if !$scope.$$phase

  $rootScope.$on 'currentVideoTime', (event, args) ->
    if $scope.currentVideoTime != args.time
      $scope.currentVideoTime = args.time
      $scope.videoDuration = args.duration
      $scope.progressValue = calculateProgress($scope.currentVideoTime, $scope.videoDuration)

      $scope.$digest()

  $scope.invokeAction = (action) ->
    $rootScope.$emit 'userAction', {action: action}

  $scope.restartGame = ->
    $rootScope.$emit 'restartGame', {}

  $scope.selectGameDifficulty = (difficulty, editMode='false')->
    $rootScope.$emit('selectDifficulty', {difficulty: difficulty, editMode: editMode})
