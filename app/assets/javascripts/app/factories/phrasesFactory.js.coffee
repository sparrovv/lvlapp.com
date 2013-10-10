LApp.factory 'Phrase', ($resource) ->
  allPhrases = []

  PhraseResource = $resource '/audio_videos/:audioVideoId/phrases/:phraseId', {audioVideoId: '@audioVideoId'},

    query: {method:'GET', params:{phraseId:''}, isArray:true}

  @all = (opts) ->
    allPhrases =  PhraseResource.query(opts)

  @create = (opts)->
    return false if @findByName(opts.name)

    index = allPhrases.push(_.extend({loading: 'loading'}, opts))

    PhraseResource.save opts, (p)->
      allPhrases[index-1] = p

  @remove = (opts)->
    PhraseResource.delete opts, (p)->
      phrase = _.find allPhrases, (phrase) ->
        phrase.id is p.id

      index = allPhrases.indexOf(phrase)
      allPhrases.splice(index, 1)

  @findByName = (name) ->
    _.find allPhrases, (phrase) ->
      phrase.name == name

  this
