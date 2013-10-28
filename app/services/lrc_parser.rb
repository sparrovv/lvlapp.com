require 'bigdecimal'

module LRC
  class Meta
    def initialize()
    end
  end

  class Line
    attr_reader :text, :start_time, :end_time

    def initialize(text, start_time, end_time)
      @text, @start_time, @end_time = text, start_time, end_time
    end

    def to_hash
      {
        'time' => start_time,
        'text' => text
      }
    end

    def to_s
      "#{@text} [#{@start_time}..#{@end_time}]"
    end

    def duration
    end
  end

  class Parser
    def initialize(content)
      entries = []
      meta_information = []

      content.each_line do |line|
        line.sub!(/\s*\Z/, "")
        if line =~ /\A\[[A-Za-z]{1,}/
          meta_information << line
          next
        end

        line =~ /\A((\[.*?\]){1,})(.*?)\Z/ or raise "Cannot parse: #{$1}"
        times, txt = $1, $3

        times.split(/\[(.*?)\]/).reject(&:empty?).each do |time|
          next unless time =~ /\A(\d+):(\d+(\.\d+)?)\Z/

          entries << [$1.to_i*60 + BigDecimal.new($2), txt]
        end
      end

      @lines = []

      entries.size.times{|i|
        cur, nxt = entries[i], entries[i+1]||[nil]
        @lines << Line.new(cur[1], cur[0], nxt[0])
      }
    end

    def lvl_app_lines
      @lvl_app_lines ||= @lines.map do |line|
        line.to_hash
      end.sort_by do |h|
        h['time'].to_f
      end
    end
  end
end

