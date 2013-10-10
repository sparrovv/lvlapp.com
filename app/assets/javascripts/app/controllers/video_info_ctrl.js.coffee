LApp.controller "VideoInfoCtrl", ($scope, $rootScope) ->
  $scope.currentVideoTime = '0.0'

  $rootScope.$on 'currentVideoTime', (event, args) ->
    $scope.currentVideoTime = args.time
