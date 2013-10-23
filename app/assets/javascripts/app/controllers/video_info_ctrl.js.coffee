LApp.controller "VideoInfoCtrl", ($scope, $rootScope) ->
  $scope.currentVideoTime = '0.0'
  $scope.videoDuration = 0
  $scope.progressValue = 0


  $rootScope.$on 'currentVideoTime', (event, args) ->
    $scope.currentVideoTime = args.time
    $scope.videoDuration = args.duration
    $scope.progressValue = (parseInt($scope.currentVideoTime) / parseInt($scope.videoDuration)) * 100
