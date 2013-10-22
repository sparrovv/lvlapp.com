LApp.controller "AdminActionsCtrl", ($scope, $rootScope, GameConfig, audioVideo, audioVideoResource) ->
  $scope.invokeAction = (action) ->
    $rootScope.$emit 'userAction', {action: action}

  videoCallbacks = ->
    #noop

  LApp.VideoPlayerFactory.init($scope, GameConfig.isYoutubeVideo(), videoCallbacks)

  $scope.saveVideoDuration = ->
    duration =  $scope.videoPlayer.duration()
    audioVideoResource.update({audioVideoId: audioVideo.id, duration: duration })

