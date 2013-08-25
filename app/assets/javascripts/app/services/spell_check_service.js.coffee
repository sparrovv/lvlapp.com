LApp.spellCheckService = (transcriptFactory, $scope) ->
  self = this

  @nextLetter = (letter) ->
    line = transcriptFactory.firstWithBlanks()
    console.log('guessed') if line.guess(letter)
    $scope.$apply()

    if line.isMatchingOrignal()
      $scope.videoPlayer.play()

  @skipWord = ->
    line = transcriptFactory.firstWithBlanks()
    line.clearBuffer()
    nextWord = line.nextMissingWord()

    if nextWord
      line.guess(nextWord)
      $scope.$apply()

  this
