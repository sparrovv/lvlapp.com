LApp.controller "VideoInfoCtrl", ($scope, $rootScope, GameStates) ->
  $scope.currentVideoTime = 0
  $scope.videoDuration = 0
  $scope.progressValue = 0
  $scope.currentState = GameStates.current

  calculateProgress = (currentVideoTime, videoDuration)->
    (parseInt(currentVideoTime) / parseInt(videoDuration)) * 100

  $rootScope.$on 'currentVideoTime', (event, args) ->
    if $scope.currentVideoTime != args.time
      $scope.currentState = GameStates.current
      $scope.currentVideoTime = args.time
      $scope.videoDuration = args.duration
      $scope.progressValue = calculateProgress($scope.currentVideoTime, $scope.videoDuration)

      $scope.$digest()

  $scope.invokeAction = (action) ->
    $rootScope.$emit 'userAction', {action: action}

  $scope.restartGame = ->
    $rootScope.$emit 'restartGame', {}

