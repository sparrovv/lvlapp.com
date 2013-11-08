LApp.factory 'SpellChecker', (Stats, transcriptFactory) ->

  _playNextLine = (line, $scope) ->
    return false unless line.isMatchingOrignal()

    if transcriptFactory.isLastLine(line)
      if $scope.videoPlayer.isEnded()
        $scope.endVideo()
        return

    nextLine = transcriptFactory.getNext(line)
    return if !nextLine
    return if nextLine == line

    diff = $scope.videoPlayer.currentTime() - nextLine.time
    maxNumberOfSecondsUntilYouStartTheLineOver = 2

    isLastLine = transcriptFactory.isLastLine(nextLine)
    if (maxNumberOfSecondsUntilYouStartTheLineOver > diff) && !isLastLine
      $scope.videoPlayer.play()
    else
      $scope.setCurrentLine(nextLine)

  nextLetter: (letter, $scope) ->
    line = transcriptFactory.firstWithBlanks()

    result = line.guess(letter)

    Stats.increaseGuessed() if result.correctWord
    Stats.increaseMistakes() if !result.correctLetter

    $scope.$apply()

    _playNextLine(line, $scope)

  skipWord: ($scope) ->
    line = transcriptFactory.firstWithBlanks()
    return unless line

    line.clearBuffer()
    nextWord = line.nextMissingWord()

    return false unless nextWord

    Stats.increaseSkpped()
    line.guess(nextWord)
    _playNextLine(line, $scope)
    $scope.$digest() if !$scope.$$phase
