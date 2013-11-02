LApp.service 'Stats',
  class Stats
    constructor: (GameData, scoreCalculator) ->
      @gameData = GameData
      @scoreCalculator = scoreCalculator

      @_setupShared()

    init: (attr)->
      @_setupShared()
      @blanks = attr.blanks
      @startTime = new Date()
      @videoDuration = attr.videoDuration
      @level = attr.level
      @audioVideoId = attr.audio_video_id

    persist: ->
      @_setTime()
      score = @generateScore()
      @total_points = score.total_points
      @gameData.save
        total_points: @total_points
        blanks: @blanks
        guessed: @guessed
        skipped: @skipped
        mistakes: @mistakes
        time: @time
        level: @level
        audioVideoId: @audioVideoId
        summary: score

    currentTime: ->
      if @time != 0
        @time
      else if @startTime
        new Date - @startTime
      else
        '0'

    increaseSkpped: ->
      @skipped += 1

    increaseGuessed: ->
      @guessed += 1

    increaseMistakes: ->
      @mistakes += 1

    generateScore: ->
      @scoreCalculator.calculate(@)

    _setupShared: ->
      @total_points = 0
      @guessed = 0
      @skipped = 0
      @mistakes = 0
      @time = 0
      @blanks = 0

    _setTime: ->
      @time = ((new Date()) - @startTime) / 1000
