@LApp.filter 'onlyTimeAndText', ->
  (input, withTag) ->

    _filterTranscript = (transcript) ->
      foo = []
      _.each transcript, (line) ->
        unless line.index == 0
          foo.push
            time: line.time
            text: line.text

      foo

    _filterTranscript(input)
