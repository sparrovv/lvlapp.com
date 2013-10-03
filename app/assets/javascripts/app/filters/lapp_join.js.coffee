@LApp.filter 'millisecondsToTime', ->
  (input, withTag) ->

    _millisecondsToTime = (milli) ->
      milliseconds = milli % 1000
      seconds = Math.floor((milli / 1000) % 60)
      minutes = Math.floor((milli / (60 * 1000)) % 60)

      minutes + "m " + seconds + "s"

    _millisecondsToTime(input)
