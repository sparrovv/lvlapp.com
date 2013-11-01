describe "easyLevelBlanksGenerator", ->
  beforeEach(module('LApp'))

  describe 'cutRandomWord', ->

    it "sorts and randomly takes one of the longest words greater than 3 chars", inject((blanksHelper) ->
      text = 'Hey is there any problem, don\'t overcomplicate'

      expect(blanksHelper.cutRandomWord(text).length).toBeGreaterThan(5)

      text = 'obscure it you bay'
      expect(blanksHelper.cutRandomWord(text)).toBe('obscure')
    )

    it "returns no_match if all words are too short", inject((blanksHelper) ->
      text = 'Hey is the any'
      expect(blanksHelper.cutRandomWord(text)).toBe(blanksHelper.NO_MATCH)
      text = ''
      expect(blanksHelper.cutRandomWord(text)).toBe(blanksHelper.NO_MATCH)
    )

