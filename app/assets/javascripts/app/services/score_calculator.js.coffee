LApp.service 'scoreCalculator',
  class scoreCalculator
    calculate: (statsData) ->
      skippedToGuessedRatio = statsData.skipped / statsData.guessed
      bonusTimeFactor =
        @_bonusTimePoints(statsData.videoDuration, statsData.time, skippedToGuessedRatio)

      timeBonus = statsData.guessed * bonusTimeFactor

      total_points: statsData.guessed + timeBonus
      guessed_points: statsData.guessed
      time_bonus: timeBonus

    _bonusTimePoints: (videoDuration, gameDuration, skippedToGuessedRatio) ->
      return 0  if skippedToGuessedRatio >  0.42

      if (videoDuration * 1.2) > gameDuration
        0.3
      else
        0


