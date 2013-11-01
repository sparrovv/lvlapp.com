LApp.service 'lineTimeoutService',
  class LineTimeout
    constructor: (GameConfig)->
      @nextLineTimeout = null
      @volumeInterval = null
      @gameConfig = GameConfig

    clearVolumeInterval: ($scope)->
      clearInterval(@volumeInterval)
      @volumeInterval = null
      $scope.videoPlayer.setVolume(@gameConfig.volumeMax)

    clearNextLineTimeout: ($scope)->
      @clearVolumeInterval($scope)
      clearTimeout(@nextLineTimeout)
      @nextLineTimeout = null

    pauseOnNonFinishedLine: ($scope)->
      self = @
      startVolume = @gameConfig.volumeMax

      volumeDown = ->
        startVolume -=2
        if startVolume > 0
          $scope.videoPlayer.setVolume(startVolume)
        else
          self.clearVolumeInterval($scope)

      pauseABitLater = ->
        if not $scope.currentLine.isMatchingOrignal()
          $scope.pause()

      if not @nextLineTimeout
        @volumeInterval = setInterval(volumeDown, 50)
        @nextLineTimeout = setTimeout(pauseABitLater, 2500)
