LApp.controller "PhrasesCtrl", ($scope, Phrase) ->
  audioVideoId = window.audioVideoId || 1 #@todo 

  $scope.phrases = Phrase.all(audioVideoId: audioVideoId)

  $scope.removePhrase = ->
    Phrase.remove(audioVideoId: this.phrase.audio_video_id, phraseId: this.phrase.id)

