LApp.controller "HelpCtrl", ($scope, $rootScope, GameConfig) ->
  $scope.invokeAction = (action) ->
    $rootScope.$emit 'userAction', {action: action}

