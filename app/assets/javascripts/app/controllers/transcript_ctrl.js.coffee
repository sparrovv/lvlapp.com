LApp.controller "TranscriptCtrl", ($scope, $timeout, $rootScope, LineTorch, GameConfig, GameStates, transcriptFactory, Stats, Key, audioVideo, SpellChecker, lineTimeoutService, Phrase) ->
  setCurrentState= (state) ->
    GameStates.current = state
    $scope.currentState = state

  setCurrentState(GameStates.loading)
  $scope.currentLineTopPosition = GameConfig.lineStartPosition
  $scope.level = 'normal'

  $scope.stats = Stats
  $scope.transcriptFactory = transcriptFactory
  $scope.transcript = transcriptFactory.transcript
  $scope.transcriptTimeRange = LApp.getTimeRange($scope.transcript)
  $scope.currentLine = $scope.transcript[0]

  bindNewLineListener = ->
    $scope.removeNewLineListener = $scope.$on "newLine", (event, newLine) ->
      if $scope.currentLine.isMatchingOrignal()
        nextLine = transcriptFactory.getNext($scope.currentLine)
        $scope.currentLine = nextLine
        lineTimeoutService.clearNextLineTimeout($scope)
        $scope.$digest() if !$scope.$$phase
      else
        lineTimeoutService.pauseOnNonFinishedLine($scope)

  videoCallbacks = (videoPlayer) ->
    currentTimeInterval = null
    updateCurrentTime = ->
      $rootScope.$emit('currentVideoTime', {time: videoPlayer.currentTime(), duration: videoPlayer.duration()})

    onVideoStart = ->
      return if $scope.currentState != GameStates.loading # safeguard, so it won't triggered twice
      console.log 'videoStarted'

      bindKeyDownKeyPress() if $scope.editMode != 'true'
      bindKeyDownControlls() if $scope.editMode == 'true'

      transcriptFactory.setupBlanks($scope.level)
      Stats.init
        level: $scope.level, audio_video_id: audioVideo.id, blanks: transcriptFactory.numberOfBlanks()
      $scope.$digest()
      $scope.play()
      bindNewLineListener()
      $('#transcript-player').focus()

      currentTimeInterval = setInterval(updateCurrentTime, 300)

    onVideoEnded = ->
      $scope.removeNewLineListener()
      setCurrentState(GameStates.finished)
      Stats.persist()
      clearInterval(currentTimeInterval)

    setCurrentState(GameStates.setup)
    $scope.$digest() if !$scope.$$phase
    videoPlayer.onVideoStart(onVideoStart)
    videoPlayer.onVideoEnded(onVideoEnded)

  LApp.VideoPlayerFactory.init($scope, GameConfig.isYoutubeVideo(), videoCallbacks)

  $scope.navigator = LApp.navigateOverTranscript($scope, transcriptFactory)

  $scope.$watch "currentLine", ->
    LineTorch.highlight($scope.currentLine, $scope)

  $scope.setCurrentLine = (line) ->
    lineTimeoutService.clearNextLineTimeout($scope)
    $scope.currentLine = line
    setCurrentState(GameStates.playing)
    $scope.videoPlayer.setCurrentTime(line.time)
    $scope.$digest() if !$scope.$$phase

  unbindKeyDownKeyPress = ->
    $(document).unbind('keypress')
    $(document).unbind('keydown')

  _emit = (action) ->
    $rootScope.$emit 'userAction', {action: action}

  bindKeyDownControlls = ->
    $(document).keydown (e) ->
      if Key.isEnter(e.keyCode)
        _emit('togglePlayer')
        return false

      #if Key.isKeyLeft(e.keyCode)
        #_emit('beginningOfline')
        #return false

      if Key.isKeyDown(e.keyCode)
        _emit('lineDown')
        return false

      if Key.isKeyUp(e.keyCode)
        _emit('lineUp')
        return false

  bindKeyDownKeyPress = ->
    $(document).keypress (event) ->
      return false if Key.isSpecial(event.keyCode) # firefox accepts keyCode, chrome which and keyCode

      letter = String.fromCharCode(event.which)
      SpellChecker.nextLetter letter, $scope

    $(document).keydown (e) ->
      _emit('togglePlayer')    if Key.isSpacebar(e.keyCode)
      _emit('lineDown')        if Key.isKeyDown(e.keyCode)
      _emit('lineUp')          if Key.isKeyUp(e.keyCode)
      _emit('beginningOfline') if Key.isEnter(e.keyCode) || Key.isKeyLeft(e.keyCode)
      _emit('skipWord')        if Key.isTab(e.keyCode)

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
    setCurrentState(GameStates.playing)

    if $scope.currentLine.isMatchingOrignal()
      $scope.videoPlayer.play()
    else
      line = $scope.currentLine
      $scope.videoPlayer.setCurrentTime(line.time)

    $scope.$digest() if !$scope.$$phase

  $scope.pause = ->
    setCurrentState(GameStates.paused)
    lineTimeoutService.clearNextLineTimeout($scope)
    $scope.videoPlayer.pause()
    $scope.$digest() if !$scope.$$phase

  restartGame = ->
    $scope.removeNewLineListener()
    $scope.currentLine = $scope.transcript[0]
    unbindKeyDownKeyPress()
    setCurrentState(GameStates.setup)
    $scope.videoPlayer.restart()

  $rootScope.$on 'restartGame', (event, args) ->
    return if GameStates.isNotStarted($scope.currentState)

    restartGame()

  $scope.selectGameLevel = (level, editMode='false')->
    $scope.level = level
    $scope.editMode = editMode
    setCurrentState(GameStates.loading)
    $scope.videoPlayer.start()

  $rootScope.$on 'userAction', (event, args) ->
    return unless GameStates.isStarted($scope.currentState)
    action = args.action

    $scope.togglePlayer()              if action == 'togglePlayer'
    $scope.navigator.lineDown()        if action == 'lineDown'
    $scope.navigator.lineUp()          if action == 'lineUp'
    $scope.navigator.beginningOfline() if action == 'beginningOfline'
    SpellChecker.skipWord($scope)      if action == 'skipWord'

  $scope.addToPhrasebook = (attrs) ->
    return false if attrs.word.match(new RegExp(GameConfig.blankChar))
    sanitizedWord = attrs.word.replace(/\W/g,'')

    Phrase.create audioVideoId: audioVideo.id, name: sanitizedWord, sentence: attrs.sentence

  window.scope = $scope
