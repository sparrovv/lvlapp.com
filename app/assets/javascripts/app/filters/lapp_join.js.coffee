@LApp.filter 'joinwith', ->
  (input, withTag) ->
    #bar = ''
    #foo = ['<div>',bar,'</div>']

    console.log input
    json = JSON.parse input
    console.log json

    #biz = _.map json, (i) ->
      #['<div>',i,'</div>'].join('')

    json.join(', ')


