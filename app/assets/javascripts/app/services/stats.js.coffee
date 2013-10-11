LApp.service 'Stats',
  class Stats
    constructor: (GameData) ->
      @gameData = GameData
      @_setupShared()

    init: (attr)->
      @_setupShared()
      @blanks = attr.blanks
      @startTime = new Date()
      @level = attr.level
      @audioVideoId = attr.audio_video_id

    persist: ->
      @_setTime()
      @gameData.save
        blanks: @blanks
        guessed: @guessed
        skipped: @skipped
        mistakes: @mistakes
        time: @time
        level: @level
        audioVideoId: @audioVideoId

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

    _setupShared: ->
      @guessed = 0
      @skipped = 0
      @mistakes = 0
      @time = 0
      @blanks = 0

    _setTime: ->
      @time = (new Date()) - @startTime
