describe "filterOutWeirdWords", ->
  beforeEach(module('LApp'))

  describe 'filtering weird words', ->

    it "filters out special chars", inject((blanksHelper) ->
      text = 'Hey!()'
      expect(blanksHelper.filterOutWeirdWords(text)).toEqual(['Hey'])

      text = '"<,.Hey?>;:'
      expect(blanksHelper.filterOutWeirdWords(text)).toEqual(['Hey'])
    )

    it "filters out words with apostrophe", inject((blanksHelper) ->
      text = "don't be"
      expect(blanksHelper.filterOutWeirdWords(text)).toEqual(['be'])

      text = "don'"
      expect(blanksHelper.filterOutWeirdWords(text)).toEqual([''])

      text = "michal's shoes"
      expect(blanksHelper.filterOutWeirdWords(text)).toEqual(['shoes'])

      text = "'michal shoes"
      expect(blanksHelper.filterOutWeirdWords(text)).toEqual(['shoes'])
    )

    it "filters out words with apostrophe", inject((blanksHelper) ->
      text = "michal's"
      expect(blanksHelper.filterOutWeirdWords(text)).toEqual([''])
    )

    it "filters out words that has more than 2 same letters in a row", inject((blanksHelper) ->
      text = "ooo foo llll"
      expect(blanksHelper.filterOutWeirdWords(text)).toEqual(['foo'])

      text = "don't foo lll kickaboom"
      expect(blanksHelper.filterOutWeirdWords(text)).toEqual(['foo', 'kickaboom'])
    )

