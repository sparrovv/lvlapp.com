LApp.factory 'Phrase', (PhraseResource) ->
  allPhrases = []

  @all = (opts) ->
    allPhrases =  PhraseResource.query(opts)

  @create = (opts)->
    result = { errors: [] }
    sanitizedWord = opts.name.replace(/[^a-z\-]/ig,'').toLowerCase()

    if sanitizedWord.length < 2
      result.errors.push('Phrase should have at least 2 characters')

    if @_findByName(sanitizedWord)
      result.errors.push('This phrase is already in phrasebook')

    return result if result.errors.length > 0

    opts.name = sanitizedWord
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
      phrase.name.toLowerCase() == name.toLowerCase()

  this
