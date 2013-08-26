LApp.factory 'Stats', () ->
  stats = 
    allBlanks:  0
    guessed: 0
    skipped: 0

  stats.setBlanks = (blanks)->
    stats.allBlanks = blanks

  stats.increaseSkpped = ()->
    stats.skipped += 1

  stats.increaseGuessed = ()->
    stats.guessed += 1

  stats
