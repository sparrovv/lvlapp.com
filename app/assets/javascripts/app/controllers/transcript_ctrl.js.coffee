LApp.controller "TranscriptCtrl", ($scope, $timeout, $rootScope, LineTorch, GameConfig, GameStates, transcriptFactory, Stats, Key, audioVideo, SpellChecker, lineTimeoutService) ->
  $scope.currentState = GameStates.loading
  $scope.currentLineTopPosition = GameConfig.lineStartPosition
  $scope.level = 'normal'

  $scope.stats = Stats
  $scope.transcript = transcriptFactory.transcript
  $scope.transcriptTimeRange = LApp.getTimeRange($scope.transcript)
  $scope.currentLine = $scope.transcript[0]

  bindNewLineListener = ->
    $scope.$on "newLine", (event, newLine) ->
      if $scope.currentLine.isMatchingOrignal()
        nextLine = transcriptFactory.getNext($scope.currentLine)
        $scope.currentLine = nextLine
        lineTimeoutService.clearNextLineTimeout($scope)
        $scope.$digest() if !$scope.$$phase
      else
        lineTimeoutService.pauseOnNonFinishedLine($scope)

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

  $scope.$watch "currentLine", ->
    LineTorch.highlight($scope.currentLine, $scope)

  $scope.setCurrentLine = (line) ->
    lineTimeoutService.clearNextLineTimeout($scope)
    $scope.currentLine = line
    $scope.currentState = GameStates.playing
    $scope.videoPlayer.setCurrentTime(line.time)
    $scope.$digest() if !$scope.$$phase

  unbindKeyDownKeyPress = ->
    $(document).unbind('keypress')
    $(document).unbind('keydown')

  bindKeyDownKeyPress = ->
    $(document).keypress (event) ->
      return false if Key.isSpecial(event.keyCode) # firefox accepts keyCode, chrome which and keyCode

      letter = String.fromCharCode(event.which)
      SpellChecker.nextLetter letter, $scope

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
    lineTimeoutService.clearNextLineTimeout($scope)
    $scope.currentState = GameStates.playing

    if $scope.currentLine.isMatchingOrignal()
      $scope.videoPlayer.play()
    else
      line = $scope.currentLine
      $scope.videoPlayer.setCurrentTime(line.time)

    $scope.$digest() if !$scope.$$phase

  $scope.pause = ->
    $scope.currentState = GameStates.paused
    lineTimeoutService.clearNextLineTimeout($scope)
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
    SpellChecker.skipWord($scope)      if action == 'skipWord'

  window.scope = $scope
