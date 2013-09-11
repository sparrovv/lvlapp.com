# TODO
# @fixme: lrc files has always inforamtion about track
# invalid format: [ti:maybe]\r\n[ar:Jay Sean]\r\n[00:00.00]Jay Sean]
#
class LRCConverter
  def convert(lrc_content)
    lrc_content.split("\n").map do |line|
      foo = line.gsub("\\",'').strip.scan(/\A\[(.+)\](.+)?/).flatten

      {
        'time' => convert_time_to_sec(foo[0]).to_s,
        'text' => foo[1].to_s
      }
    end
  end

  def shift_time_by(subtiles, seconds)
    subtiles.dup.map do |line|
      line['time'] += seconds

      line
    end
  end

  def convert_time_to_sec(time)
    # convers time in format: 01:12.12 to secs
    foo = time.split(':')
    minutes = Integer(foo[0])
    seconds = BigDecimal(foo[1])

    (minutes * 60) + seconds
  end
end
