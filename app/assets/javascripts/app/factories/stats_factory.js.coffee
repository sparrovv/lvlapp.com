LApp.factory 'Stats', (GameData) ->
  stats =
    blanks:  0
    guessed: 0
    skipped: 0
    mistakes: 0
    time: 0

  stats.attributes = ->
    blanks: stats.blanks
    guessed: stats.guessed
    skipped: stats.skipped
    mistakes: stats.mistakes
    time: stats.time
    level: stats.level
    audioVideoId: stats.audioVideoId

  stats.init = (attr)->
    stats.skipped = 0
    stats.guessed = 0
    stats.mistakes = 0
    stats.startTime = new Date()
    stats.level = attr.level
    stats.audioVideoId = attr.audio_video_id
    stats.blanks = attr.blanks

  stats.persist = ->
    stats._setTime()
    GameData.save stats.attributes()

  stats.setBlanks = (blanks)->
    stats.blanks = blanks

  stats.increaseSkpped = ()->
    stats.skipped += 1

  stats.increaseGuessed = ()->
    stats.guessed += 1

  stats.increaseMistakes = ()->
    stats.mistakes += 1

  stats._setTime = ->
    stats.time = (new Date()) - stats.startTime

  stats
