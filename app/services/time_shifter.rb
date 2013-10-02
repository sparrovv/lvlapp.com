class TimeShifter
  def self.shift_by(subtiles, seconds)
    subtiles.dup.map do |line|
      line['time'] += seconds

      line
    end
  end
end
