LApp.controller "StatsCtrl", ($scope, Stats) ->
  $scope.stats = Stats

  $scope.$on 'currentStatTime', (event, args) ->
    $scope.currentTime = args.time
    $scope.$digest() if !$scope.$$phase

  updateCurrentTimeInterval = ->
    $scope.$emit('currentStatTime', {time: Stats.currentTime()})

  # looks like there were some perfromance issues with $timeout,
  # maybe make sense to try that in the future agian, but for now setInterval works
  setInterval(updateCurrentTimeInterval, 1000)
