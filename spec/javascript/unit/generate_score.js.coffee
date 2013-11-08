describe "generateScore", ->
  beforeEach(module('LApp'))

  describe 'generateScore', ->
    it "generates general score based on guessed words", inject((Stats) ->
      Stats.guessed = 10 #
      Stats.skipped = 0 # is skip more than 30% no bonusess
      Stats.time = 20 # when it took you less than the video is taken / depends on lvl
      Stats.videoDuration = 20
      Stats.videoLevel = 'medium'

      expectedResult =
        total_points: 60 + (60 * 0.3)
        level_factor: 6
        guessed_points: 10
        time_bonus: 60 * 0.3

      expect(Stats.generateScore()).toEqual(expectedResult)
    )

    it "doesn't add time bonus if there was to many skipped (> ~33%)", inject((Stats) ->
      Stats.guessed = 12
      Stats.skipped = 6
      Stats.time = 20 # when it took you less than the video is taken / depends on lvl
      Stats.videoDuration = 20
      Stats.videoLevel = 'easy'

      expectedResult =
        total_points: 12 * 5
        level_factor: 5
        guessed_points: 12
        time_bonus: 0

      expect(Stats.generateScore()).toEqual(expectedResult)
    )

    it "doesn't add time bonus if game duration was longer than 120% of video duration", inject((Stats) ->
      Stats.guessed = 12
      Stats.skipped = 0
      Stats.time = 24.1 # when it took you less than the video is taken / depends on lvl
      Stats.videoDuration = 20
      Stats.videoLevel = 'hard'

      expectedResult =
        total_points: 12 * 7
        guessed_points: 12
        level_factor: 7
        time_bonus: 0

      expect(Stats.generateScore()).toEqual(expectedResult)
    )
