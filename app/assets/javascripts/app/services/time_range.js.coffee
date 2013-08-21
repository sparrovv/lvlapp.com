LApp.getTimeRange = (transcript) ->
  timeRange = _.map(transcript, (obj, i) ->
    nextTime = null
    nextLine = transcript[i + 1]
    startTime = parseFloat(obj.time)
    if nextLine
      nextTime = parseFloat(nextLine.time)
    else
      nextTime = startTime + 100
    range: [startTime, nextTime]
    line: obj
  )
  timeRange
