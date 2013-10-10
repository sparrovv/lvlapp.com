LApp.factory 'Phrase', (PhraseResource) ->
  allPhrases = []

  @all = (opts) ->
    allPhrases =  PhraseResource.query(opts)

  @create = (opts)->
    return false if @_findByName(opts.name)

    index = allPhrases.push(_.extend({loading: 'loading'}, opts))

    PhraseResource.save opts, (p)->
      allPhrases[index-1] = p

  @remove = (opts)->
    PhraseResource.delete opts, (p)->
      phrase = _.find allPhrases, (phrase) ->
        phrase.id is p.id

      index = allPhrases.indexOf(phrase)
      allPhrases.splice(index, 1)

  @_findByName = (name) ->
    _.find allPhrases, (phrase) ->
      phrase.name == name

  this
