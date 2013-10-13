LApp.service "SM2Mod",
  class SM2Mod
    calculate: (quality_response, prev_interval, prev_ef=2.5) ->
      prev_interval = prev_interval || 0

      # if quality_response is below 3 start repetition from the begining,
      # but without changing easiness_factor
      if quality_response < 2
        calculatedInterval = 0
        calculatedEasinessFactor = prev_ef
      else
        calculatedEasinessFactor = @calculate_easiness_factor(prev_ef, quality_response)
        calculatedInterval = @calculate_interval(quality_response, prev_interval, prev_ef)

      { easinessFactor: calculatedEasinessFactor, interval: calculatedInterval, nextRepetitionDate: @calculate_date(calculatedInterval)}

    calculate_interval: (quality_response, prev_interval, prev_ef) ->
      if prev_interval == 0
        calculated_interval = 1

        if quality_response == 3
          calculated_interval = 6
        else if prev_interval == 1
          calculated_interval = 6
      else
        calculated_interval = parseInt(prev_interval * prev_ef)

      calculated_interval

    calculate_easiness_factor: (prev_ef, quality_response) ->
      calculated_ef =
        prev_ef + (0.1 - (3 - quality_response) * ((3 - quality_response)*0.1))

      if calculated_ef < 1.3
        calculated_ef = 1.3

      calculated_ef

    calculate_date: (calculated_interval) ->
      today = new Date()
      today.setDate(today.getDate() + calculated_interval)

