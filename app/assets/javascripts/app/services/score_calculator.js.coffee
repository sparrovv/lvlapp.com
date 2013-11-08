LApp.service 'scoreCalculator',
  class scoreCalculator
    calculate: (statsData) ->
      skippedToGuessedRatio = statsData.skipped / statsData.guessed
      bonusTimeFactor =
        @_bonusTimePoints(statsData.videoDuration, statsData.time, skippedToGuessedRatio)

      levelFactor = @_levelFactor(statsData.videoLevel)
      preTotalPoints = statsData.guessed * levelFactor
      timeBonus = preTotalPoints * bonusTimeFactor

      total_points: preTotalPoints + timeBonus
      level_factor: levelFactor
      guessed_points: statsData.guessed
      time_bonus: timeBonus

    _bonusTimePoints: (videoDuration, gameDuration, skippedToGuessedRatio) ->
      return 0  if skippedToGuessedRatio >  0.42

      if (videoDuration * 1.2) > gameDuration
        0.3
      else
        0

    _levelFactor: (level) ->
      {
        'easy': 5,
        'medium': 6,
        'hard': 7
      }[level]

