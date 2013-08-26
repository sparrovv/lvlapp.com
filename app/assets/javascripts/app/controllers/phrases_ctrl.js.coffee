LApp.controller "PhrasesCtrl", ($scope, Phrase, audioVideo) ->
  $scope.phrases = Phrase.all(audioVideoId: audioVideo.id)

  $scope.removePhrase = ->
    Phrase.remove(audioVideoId: this.phrase.audio_video_id, phraseId: this.phrase.id)

