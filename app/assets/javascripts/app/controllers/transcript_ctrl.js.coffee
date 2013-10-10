LApp.controller "TranscriptCtrl", ($scope, $timeout, $rootScope, GameConfig, GameStates, transcriptFactory, Stats, Key, audioVideo) ->
  $scope.currentState = GameStates.loading
  $scope.level = 'normal'

  $scope.stats = Stats
  $scope.transcript = transcriptFactory.transcript
  $scope.transcriptTimeRange = LApp.getTimeRange($scope.transcript)
  $scope.currentLine = $scope.transcript[0]

  $scope.spellChecker = new LApp.spellCheckService(transcriptFactory, $scope, Stats)

  bindNewLineListener = ->
    $scope.$on "newLine", (event, newLine) ->
      if $scope.currentLine.isMatchingOrignal()
        $scope.clearNextLineTimeout()
        $scope.currentLine = newLine
        $scope.$digest() if !$scope.$$phase
      else
        $scope.pauseOnNonFinishedLine()

  videoCallbacks = (videoPlayer) ->
    updateCurrentTimeInterval = ->
      $scope.cancelRefresh = $timeout(->
        $rootScope.$emit('currentVideoTime', {time: videoPlayer.currentTime()})

        if $scope.currentState != GameStates.finished && $scope.currentState != GameStates.setup
          $scope.cancelRefresh = $timeout(updateCurrentTimeInterval, 300)
      ,300)

    onVideoStart = ->
      return if $scope.currentState != GameStates.loading # safeguard, so it won't triggered twice
      console.log 'videoStarted'
      bindKeyDownKeyPress()
      transcriptFactory.setupBlanks($scope.level)
      Stats.init
        level: $scope.level, audio_video_id: audioVideo.id, blanks: transcriptFactory.numberOfBlanks()
      $scope.$digest()
      $scope.play()
      bindNewLineListener()
      $('#transcript-player').focus()
      updateCurrentTimeInterval()

    onVideoEnded = ->
      $scope.currentState = GameStates.finished
      Stats.persist()

    $scope.currentState = GameStates.setup
    videoPlayer.onVideoStart(onVideoStart)
    videoPlayer.onVideoEnded(onVideoEnded)

  LApp.VideoPlayerFactory.init($scope, GameConfig.isYoutubeVideo(), videoCallbacks)

  $scope.navigator = LApp.navigateOverTranscript($scope, transcriptFactory)
  $scope.currentLineTopPosition = GameConfig.lineStartPosition
  $scope.$watch "currentLine", ->
    $scope.currentLineTopPosition = GameConfig.lineStartPosition - ($scope.currentLine.index * GameConfig.lineHeight)
    LApp.highlightService $scope.currentLine

  $scope.setCurrentLine = (line) ->
    $scope.clearNextLineTimeout()
    $scope.currentLine = line
    $scope.currentState = GameStates.playing
    $scope.videoPlayer.setCurrentTime(line.time)
    $scope.$digest() if !$scope.$$phase

  $scope.nextLineTimeout = null
  $scope.volumeInterval = null
  $scope.clearVolumeInterval = ->
    clearInterval($scope.volumeInterval)
    $scope.volumeInterval = null
    $scope.videoPlayer.setVolume(GameConfig.volumeMax)

  $scope.clearNextLineTimeout = ->
    $scope.clearVolumeInterval()
    clearTimeout($scope.nextLineTimeout) 
    $scope.nextLineTimeout = null

  $scope.pauseOnNonFinishedLine = ->
    startVolume = GameConfig.volumeMax

    volumeDown = ->
      startVolume -=2
      if startVolume > 0
        $scope.videoPlayer.setVolume(startVolume)
      else
        $scope.clearVolumeInterval()

    pauseABitLater = ->
      if not $scope.currentLine.isMatchingOrignal()
        $scope.videoPlayer.pause()

    if not $scope.nextLineTimeout
      $scope.volumeInterval = setInterval(volumeDown, 50)
      $scope.nextLineTimeout = setTimeout(pauseABitLater, 2500)

  unbindKeyDownKeyPress = ->
    $(document).unbind('keypress')
    $(document).unbind('keydown')

  bindKeyDownKeyPress = ->
    $(document).keypress (event) ->
      return false if Key.isSpecial(event.keyCode) # firefox accepts keyCode, chrome which and keyCode

      letter = String.fromCharCode(event.which)
      $scope.spellChecker.nextLetter letter

    emit = (action) ->
      $rootScope.$emit 'userAction', {action: action}
    $(document).keydown (e) ->
      emit('togglePlayer')    if Key.isSpacebar(e.keyCode)
      emit('lineDown')        if Key.isKeyDown(e.keyCode)
      emit('lineUp')          if Key.isKeyUp(e.keyCode)
      emit('beginningOfline') if Key.isEnter(e.keyCode) || Key.isKeyLeft(e.keyCode)
      emit('skipWord')        if Key.isTab(e.keyCode)

      if Key.isBackspace(e.keyCode)
        e.preventDefault()
        currentLineWithBlanks = transcriptFactory.firstWithBlanks()
        currentLineWithBlanks.removeLastFromBuffer()

        $scope.$apply()

      return false  if Key.isSpecial(e.keyCode)

  $scope.togglePlayer = ->
    if $scope.currentState == GameStates.paused
      $scope.play()
    else
      $scope.pause()

  # As a workaround to make it possible to play the current paused line, it starts from the beginning.
  $scope.play = ->
    $scope.clearNextLineTimeout()
    $scope.currentState = GameStates.playing

    if $scope.currentLine.isMatchingOrignal()
      $scope.videoPlayer.play()
    else
      line = $scope.currentLine
      $scope.videoPlayer.setCurrentTime(line.time)

    $scope.$digest() if !$scope.$$phase

  $scope.pause = ->
    $scope.currentState = GameStates.paused
    $scope.clearNextLineTimeout()
    $scope.videoPlayer.pause()
    $scope.$digest() if !$scope.$$phase

  $scope.restartGame = ->
    $scope.currentLine = $scope.transcript[0]
    unbindKeyDownKeyPress()
    $scope.currentState = GameStates.setup
    $scope.level = 'normal'
    $scope.videoPlayer.setCurrentTime(0)
    $scope.videoPlayer.pause()

  $scope.selectGameLevel = (level)->
    $scope.level = level
    $scope.currentState = GameStates.loading
    $scope.videoPlayer.pause()
    $scope.videoPlayer.setCurrentTime(0)

  $rootScope.$on 'userAction', (event, args) ->
    return unless GameStates.started($scope.currentState)
    action = args.action

    $scope.togglePlayer()              if action == 'togglePlayer'
    $scope.navigator.lineDown()        if action == 'lineDown'
    $scope.navigator.lineUp()          if action == 'lineUp'
    $scope.navigator.beginningOfline() if action == 'beginningOfline'
    $scope.spellChecker.skipWord()     if action == 'skipWord'

  window.scope = $scope

