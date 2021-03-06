LApp.controller "TranscriptCtrl", ($scope, $rootScope, GameConfig, GameStates, transcriptFactory, Stats, Key, audioVideo, SpellChecker, lineTimeoutService, Phrase) ->
  setCurrentState= (state) ->
    GameStates.current = state
    $scope.currentState = state
    $rootScope.$emit 'stateChanged', {state: state}

  currentTimeInterval = null
  setCurrentState(GameStates.loading)
  $scope.currentLineTopPosition = GameConfig.lineStartPosition
  $scope.difficulty = 'normal'

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
    updateCurrentTime = ->
      $rootScope.$emit('currentVideoTime', {time: videoPlayer.currentTime(), duration: videoPlayer.duration()})

    onVideoPause = ->
      $('#transcript-player').focus()

    onVideoPlay = ->
      $('#transcript-player').focus()
      return if $scope.currentState != GameStates.paused
      $scope.play()

    onVideoStart = ->
      return if $scope.currentState != GameStates.loading # safeguard, so it won't triggered twice
      console.log 'videoStarted'

      bindKeyDownKeyPress() if $scope.editMode != 'true'
      bindKeyDownControlls() if $scope.editMode == 'true'

      transcriptFactory.setupBlanks($scope.difficulty)
      $scope.firstWithBlanks = transcriptFactory.firstWithBlanks()

      Stats.init
        difficulty: $scope.difficulty
        videoLevel: audioVideo.level_name
        videoDuration: videoPlayer.duration()
        audio_video_id: audioVideo.id
        blanks: transcriptFactory.numberOfBlanks()
      $scope.$digest()
      $scope.play()
      bindNewLineListener()

      currentTimeInterval = setInterval(updateCurrentTime, 300)

    onVideoEnded = ->
     unless $scope.currentLine.isMatchingOrignal()
       console.log 'reached the end of video but the current line is not matching original'
       return

     $scope.endVideo()

    setCurrentState(GameStates.setup)
    $scope.$digest() if !$scope.$$phase
    videoPlayer.onVideoStart(onVideoStart)
    videoPlayer.onVideoEnded(onVideoEnded)
    videoPlayer.onVideoPlay(onVideoPlay)
    videoPlayer.onVideoPause(onVideoPause)

  LApp.VideoPlayerFactory.init($scope, GameConfig.isYoutubeVideo(), videoCallbacks)

  $scope.navigator = LApp.navigateOverTranscript($scope, transcriptFactory)

  $scope.$watch "currentLine", ->
    $scope.currentLineTopPosition =
      GameConfig.lineStartPosition - ($scope.currentLine.index * GameConfig.lineHeight)
    $('ul.lines').css('top', $scope.currentLineTopPosition)

  $scope.setCurrentLine = (line) ->
    setCurrentState(GameStates.playing)
    $scope.videoPlayer.setCurrentTime(line.time)
    $scope.currentLine = line
    $scope.$digest() if !$scope.$$phase
    lineTimeoutService.clearNextLineTimeout($scope)

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
      $scope.firstWithBlanks = transcriptFactory.firstWithBlanks()

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

      return false if Key.isSpecial(e.keyCode)

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

  # this is called also in lineTimeoutService!
  $scope.pause = ->
    setCurrentState(GameStates.paused)
    lineTimeoutService.clearNextLineTimeout($scope)
    $scope.$digest() if !$scope.$$phase

    $scope.videoPlayer.pause()

  $scope.restartGame = ->
    $scope.removeNewLineListener()
    $scope.currentLine = $scope.transcript[0]
    unbindKeyDownKeyPress()
    setCurrentState(GameStates.setup)
    $scope.videoPlayer.restart()

  $rootScope.$on 'restartGame', (event, args) ->
    return if GameStates.isNotStarted($scope.currentState)

    $scope.restartGame()

  $rootScope.$on 'selectDifficulty', (event, args) ->
    $scope.difficulty = args.difficulty
    $scope.editMode = args.editMode
    setCurrentState(GameStates.loading)
    $scope.videoPlayer.start()

  $scope.endVideo = ->
    $scope.removeNewLineListener()
    setCurrentState(GameStates.finished)
    Stats.persist()
    clearInterval(currentTimeInterval)

  $rootScope.$on 'userAction', (event, args) ->
    return unless GameStates.isStarted($scope.currentState)
    action = args.action

    $scope.togglePlayer()              if action == 'togglePlayer'
    if action == 'lineDown'
      SpellChecker.skipAllWords($scope.currentLine, $scope)
      $scope.navigator.lineDown()

    $scope.navigator.lineUp()          if action == 'lineUp'
    $scope.navigator.beginningOfline() if action == 'beginningOfline'
    if action == 'skipWord'
      line = transcriptFactory.firstWithBlanks()
      SpellChecker.skipWord(line, $scope)

    $scope.firstWithBlanks = transcriptFactory.firstWithBlanks()

  $scope.addToPhrasebook = (attrs) ->
    return false if attrs.word.match(new RegExp(GameConfig.blankChar))

    Phrase.create
      audioVideoId: audioVideo.id, name: attrs.word, sentence: attrs.sentence

  window.scope = $scope
