# TODO
# @fixme: lrc files has always inforamtion about track
# invalid format: [ti:maybe]\r\n[ar:Jay Sean]\r\n[00:00.00]Jay Sean]
#
class LRCConverter
  def convert(lrc_content)
    line_collection = []
    lrc_content.each_line do |line|
      next if line.strip.blank?

      line_with_time = line.gsub("\\",'').strip.scan(/\A\[(.+)\](.+)?/).flatten
      line_collection << {
        'time' => convert_time_to_sec(line_with_time[0]).to_s,
        'text' => line_with_time[1].to_s
      }
    end

    line_collection.sort_by do |h|
      h['time'].to_f
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
