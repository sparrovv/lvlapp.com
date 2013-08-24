LApp.controller "LineCtrl", ($scope, transcriptFactory, Phrase) ->
  $scope.lookUpInDict = (e) ->
    Phrase.create audioVideoId: 1, name: e.word

