LApp.controller "LineCtrl", ($scope, GameConfig, transcriptFactory, Phrase, audioVideo) ->
  $scope.lookUpInDict = (e) ->
    return false if e.word.match(new RegExp(GameConfig.blankChar))

    word = e.word.replace(/\W/g,'')

    Phrase.create audioVideoId: audioVideo.id, name: word

