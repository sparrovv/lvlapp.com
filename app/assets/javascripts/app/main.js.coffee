@LApp = angular.module("LApp", ['ngResource'])

@LApp.config ["$httpProvider", ($httpProvider) ->
  csrfToken = $('meta[name=csrf-token]').attr('content')

  $httpProvider.defaults.headers.post['X-CSRF-Token'] = csrfToken
  $httpProvider.defaults.headers.put['X-CSRF-Token'] = csrfToken
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = csrfToken
]

@LApp.constant 'GameConfig', {volumeMax:100, lineStartPosition: 92, lineHeight: 32.5}
@LApp.constant 'GameStates', {setup: 'setup', paused: 'paused', playing: 'playing', finished: 'finished'}
