LApp.factory 'GameData', ($resource) ->
  $resource '/audio_videos/:audioVideoId/game_data/:gameDataId', {audioVideoId: '@audioVideoId'}
