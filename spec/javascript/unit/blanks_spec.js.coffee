describe "filterOutWeirdWords", ->
  beforeEach(module('LApp'))

  describe 'filtering weird words', ->

    it "filters out special chars", inject((blanksHelper) ->
      text = 'Hey!()'
      expect(blanksHelper.filterOutWeirdWords(text)).toEqual(['Hey'])

      text = '"<,.Hey?>;:*'
      expect(blanksHelper.filterOutWeirdWords(text)).toEqual(['Hey'])
    )

    it "filters out words with apostrophe and stars", inject((blanksHelper) ->
      text = "don't be"
      expect(blanksHelper.filterOutWeirdWords(text)).toEqual(['be'])

      text = "don' "
      expect(blanksHelper.filterOutWeirdWords(text)).toEqual([''])

      text = "michal's shoes f*cking"
      expect(blanksHelper.filterOutWeirdWords(text)).toEqual(['shoes'])

      text = "'michal shoes"
      expect(blanksHelper.filterOutWeirdWords(text)).toEqual(['shoes'])

      text = 'And f*cking rip-rip'
      expect(blanksHelper.filterOutWeirdWords(text)).toEqual(['And', ''])
    )

    it "filters out words with apostrophe", inject((blanksHelper) ->
      text = "michal's"
      expect(blanksHelper.filterOutWeirdWords(text)).toEqual([''])
    )

    it "filters out words that has more than 2 same letters in a row", inject((blanksHelper) ->
      text = "ooohh yes I said it"
      expect(blanksHelper.filterOutWeirdWords(text)).toEqual(['yes', 'I', 'said', 'it'])

      text = "don't foo blllah kickaboom"
      expect(blanksHelper.filterOutWeirdWords(text)).toEqual(['foo', 'kickaboom'])
    )

