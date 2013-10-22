LApp.factory 'audioVideoResource', ($resource) ->
  $resource '/audio_videos/:audioVideoId', {audioVideoId: '@audioVideoId'},

    update: {method: 'PUT'}

