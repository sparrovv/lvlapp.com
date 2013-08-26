LApp.controller "LineCtrl", ($scope, transcriptFactory, Phrase, audioVideo) ->
  $scope.lookUpInDict = (e) ->
    Phrase.create audioVideoId: audioVideo.id, name: e.word

