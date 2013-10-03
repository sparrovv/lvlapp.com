LApp.controller "StatsCtrl", ($scope, Stats, $timeout) ->
  $scope.stats = Stats

  updateCurrentTimeInterval = ->
    cancelRefresh = $timeout(->
      $scope.currentTime = Stats.currentTime()
      cancelRefresh = $timeout(updateCurrentTimeInterval, 1000)
    ,1000)

  updateCurrentTimeInterval()
