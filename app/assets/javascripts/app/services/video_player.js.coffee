class LApp.VideoPlayerFactory
  @init: (scope, isYoutubeVideo, callbacks) ->
    if isYoutubeVideo
      LApp.VideoPlayerFactory.youtube(scope, callbacks)
    else
      LApp.VideoPlayerFactory.videojs(scope, callbacks)

  @youtube: (scope, callbacks) ->
    $(document).on 'youtubeVideoLoaded' , ->
      #
      #youtubePlayer is an object on windows defined in view :////
      #
      scope.videoPlayer = new LApp.YoutubVideoPlayerProxy(youtubePlayer)
      scope.videoPlayer.onTimeUpdate(LApp.locateCurrentLine, scope)
      callbacks(scope.videoPlayer)

  @videojs: (scope, callbacks) ->
    scope.videoPlayer = new LApp.VideoJSProxy(videojs("videojs-video"))
    scope.videoPlayer.onTimeUpdate(LApp.locateCurrentLine, scope)
    callbacks(scope.videoPlayer)

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

  onVideoEnded: (funct) ->
    @original_player.on "ended", ->
      funct()

  setVolume: (v)->
    percentAsDecimal = v / 100
    @original_player.volume(percentAsDecimal)

  onVideoStart: (funct) ->
    self = @
    @original_player.on "play", ->
      if self.currentTime() < 0.12
        funct()

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

  setVolume: (v)->
    @original_player.setVolume(v)

  onTimeUpdate: (funct, $scope) ->
    self = @
    $(document).on 'youtubeVideoCurrentTime', ->
      funct(self.currentTime(), $scope)

  onVideoEnded: (funct) ->
    $(document).on 'youtubeVideoEnded', ->
      funct()

  onVideoStart: (funct) ->
    self = @
    $(document).on 'youtubeVideoStart', ->
      if self.currentTime() < 0.12
        funct()
