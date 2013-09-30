LApp.factory 'Phrase', ($resource) ->
  allPhrases = []

  PhraseResource = $resource '/audio_videos/:audioVideoId/phrases/:phraseId', {audioVideoId: '@audioVideoId'},

    query: {method:'GET', params:{phraseId:''}, isArray:true}

  @all = (opts) ->
    allPhrases =  PhraseResource.query(opts)

  @create = (opts)->
    PhraseResource.save opts, (p)->
      allPhrases.push(p)

  @remove = (opts)->
    PhraseResource.delete opts, (p)->
      phrase = _.find allPhrases, (phrase) ->
        phrase.id is p.id

      index = allPhrases.indexOf(phrase)
      allPhrases.splice(index, 1)

  this
