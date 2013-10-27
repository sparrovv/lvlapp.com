@LApp.filter 'toMinSec', ->
  (input, withTag) ->

    _toMinSec = (seconds) ->
      seconds = parseInt(seconds)

      sec = Math.floor(seconds % 60)
      sec = ['0', sec].join('') if sec < 10
      minutes = Math.floor((seconds / 60)%60)

      [minutes, ':', sec].join('')

    _toMinSec(input)
