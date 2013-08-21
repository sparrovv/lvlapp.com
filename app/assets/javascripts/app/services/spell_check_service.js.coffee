LApp.spellCheckService = (transcriptFactory, $scope) ->
  self = this

  @nextLetter = (letter) ->
    line = transcriptFactory.firstWithBlanks()
    if line.guess(letter) is true
      $scope.$apply()
      $scope.videoPlayer.play()  if line.isMatchingOrignal()

  @skipWord = ->
    line = transcriptFactory.firstWithBlanks()
    skip = line.nextWord()
    if skip
      _.each skip.split(""), (letter) ->
        self.nextLetter letter

  this
