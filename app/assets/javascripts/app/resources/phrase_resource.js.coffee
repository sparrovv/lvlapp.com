LApp.factory 'PhraseResource', ($resource) ->
  $resource '/audio_videos/:audioVideoId/phrases/:phraseId', {audioVideoId: '@audioVideoId'},

    query: {method:'GET', params:{phraseId:''}, isArray:true}
