@LApp = angular.module("LApp", ['ngResource','ui.bootstrap'])

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
  blankChar: '_'#'•'

gameStates =
  current: ''
  loading: 'starting'
  setup: 'setup'
  paused: 'paused'
  playing: 'playing'
  finished: 'finished'
  isStarted: (currentState) ->
    _.contains(['playing', 'paused'], currentState)

  isNotStarted: (currentState) ->
    _.contains(['loading', 'setup'], currentState)

@LApp.constant 'GameConfig', gameConfig
@LApp.constant 'GameStates', gameStates
