@LApp = angular.module("LApp", ['ngResource'])

@LApp.config ["$httpProvider", ($httpProvider) ->
  csrfToken = $('meta[name=csrf-token]').attr('content')

  $httpProvider.defaults.headers.post['X-CSRF-Token'] = csrfToken
  $httpProvider.defaults.headers.put['X-CSRF-Token'] = csrfToken
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = csrfToken
]

gameConfig =
  isYoutubeVideo: ->
    window.isYoutubeVideo
  volumeMax: 100
  lineStartPosition: 92
  lineHeight: 32.5
  blankChar: '•'

gameStates =
  loading: 'starting'
  setup: 'setup'
  paused: 'paused'
  playing: 'playing'
  finished: 'finished'

@LApp.constant 'GameConfig', gameConfig
@LApp.constant 'GameStates', gameStates
