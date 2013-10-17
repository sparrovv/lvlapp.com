LApp.controller "TranscriptCtrl", ($scope, $timeout, $rootScope, LineTorch, GameConfig, GameStates, transcriptFactory, Stats, Key, audioVideo, SpellChecker, lineTimeoutService, Phrase) ->
  $scope.currentState = GameStates.loading
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
    updateCurrentTimeInterval = ->
      $scope.cancelRefresh = $timeout(->
        $rootScope.$emit('currentVideoTime', {time: videoPlayer.currentTime()})

        if $scope.currentState != GameStates.finished && $scope.currentState != GameStates.setup
          $scope.cancelRefresh = $timeout(updateCurrentTimeInterval, 300)
      ,300)

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
      updateCurrentTimeInterval()

    onVideoEnded = ->
      $scope.removeNewLineListener()
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
    $scope.removeNewLineListener()
    $scope.currentLine = $scope.transcript[0]
    unbindKeyDownKeyPress()
    $scope.currentState = GameStates.setup
    $scope.level = 'normal'
    $scope.videoPlayer.setCurrentTime(0)
    $scope.videoPlayer.pause()

  $scope.selectGameLevel = (level, editMode='false')->
    $scope.level = level
    $scope.editMode = editMode
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

  $scope.addToPhrasebook = (attrs) ->
    return false if attrs.word.match(new RegExp(GameConfig.blankChar))
    word = attrs.word.replace(/\W/g,'')

    Phrase.create audioVideoId: audioVideo.id, name: attrs.word, sentence: attrs.sentence

  window.scope = $scope
