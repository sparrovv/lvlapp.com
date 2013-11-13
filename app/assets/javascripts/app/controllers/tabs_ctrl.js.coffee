LvlFront.controller "TabsCtrl", ($scope) ->
  $scope.active = 'recent'

  $scope.isActvie = (tab) ->
    console.log tab
    if $scope.active == tab
      'active'
    else
      ''

  $scope.change = (activeTab) ->
    $scope.active = activeTab
