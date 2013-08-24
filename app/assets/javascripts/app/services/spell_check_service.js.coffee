LApp.spellCheckService = (transcriptFactory, $scope) ->
  self = this

  @nextLetter = (letter) ->
    line = transcriptFactory.firstWithBlanks()
    if line.guess(letter) is true
      $scope.$apply()
      $scope.videoPlayer.play()  if line.isMatchingOrignal()

  @skipWord = ->
    line = transcriptFactory.firstWithBlanks()
    nextWord = line.nextMissingWord()
    if nextWord
      _.each nextWord.split(""), (letter) ->
        self.nextLetter letter

  this
