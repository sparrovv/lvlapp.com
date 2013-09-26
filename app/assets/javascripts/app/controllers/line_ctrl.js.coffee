LApp.controller "LineCtrl", ($scope, transcriptFactory, Phrase, audioVideo) ->
  $scope.lookUpInDict = (e) ->
    word = e.word.replace(/\W/g,'')
    Phrase.create audioVideoId: audioVideo.id, name: word

