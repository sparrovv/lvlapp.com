class LRCConverter
  def shift_time_by(subtiles, seconds)
    subtiles.dup.map do |line|
      line['time'] += seconds

      line
    end
  end
end
