describe "easyLevelBlanksGenerator", ->
  beforeEach(module('LApp'))

  rawTranscript = [
    {time: 1, text: "foooo barrrr bizzzz"},
    {time: 2, text: "foooo barrrr bizzzz"},
  ]

