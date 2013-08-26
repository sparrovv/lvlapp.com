LApp.factory 'audioVideo', () ->
  audioVideo = window.audioVideo
  audioVideo.rawTranscript = JSON.parse audioVideo.transcript

  audioVideo
