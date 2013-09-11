class LApp.VideoPlayerFactory
  @init: (scope, isYoutubeVideo) ->
    if isYoutubeVideo
      LApp.VideoPlayerFactory.youtube(scope)
    else
      LApp.VideoPlayerFactory.videojs(scope)

  @youtube: (scope) ->
    $(document).on 'youtubeVideoLoaded' , ->
      #
      #youtubePlayer is an object on windows defined in view :////
      #
      scope.videoPlayer = new LApp.YoutubVideoPlayerProxy(youtubePlayer)
      scope.videoPlayer.onTimeUpdate(LApp.locateCurrentLine, scope)

  @videojs: (scope) ->
    scope.videoPlayer = new LApp.VideoJSProxy(videojs("videojs-video"))
    scope.videoPlayer.onTimeUpdate(LApp.locateCurrentLine, scope)

class LApp.VideoJSProxy
  constructor:(@original_player) ->

  play: ->
    @original_player.play()

  pause: ->
    @original_player.pause()

  paused: ->
    @original_player.paused()

  setCurrentTime: (secs)->
    @original_player.currentTime(secs).play()

  currentTime: ->
    @original_player.currentTime()

  onTimeUpdate: (funct, scope) ->
    self = @
    @original_player.on "timeupdate", ->
      funct(self.currentTime(), scope)

class LApp.YoutubVideoPlayerProxy
  constructor:(@original_player) ->

  play: ->
    @original_player.playVideo()
  pause: ->
    @original_player.pauseVideo()

  paused: ->
    number = @original_player.getPlayerState()
    number != 1

  setCurrentTime: (secs)->
    @original_player.seekTo(secs, true)
    @play()

  currentTime: ->
    @original_player.getCurrentTime()

  onTimeUpdate: (funct, $scope) ->
    self = @
    $(document).on 'youtubeVideoCurrentTime', ->
      funct(self.currentTime(), $scope)

