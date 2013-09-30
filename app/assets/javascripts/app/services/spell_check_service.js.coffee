LApp.spellCheckService = (transcriptFactory, $scope, Stats) ->
  self = this

  _playNextLine = (line) ->
    if line.isMatchingOrignal()
      $scope.videoPlayer.play()

  @nextLetter = (letter) ->
    line = transcriptFactory.firstWithBlanks()

    result = line.guess(letter)

    Stats.increaseGuessed() if result.correctWord
    Stats.increaseMistakes() if !result.correctLetter

    $scope.$apply()

    _playNextLine(line)

  @skipWord = ->
    line = transcriptFactory.firstWithBlanks()
    line.clearBuffer()
    nextWord = line.nextMissingWord()

    if nextWord
      Stats.increaseSkpped()
      line.guess(nextWord)
      _playNextLine(line)
      $scope.$apply()

  this
