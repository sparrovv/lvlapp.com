class YoutubeTranscriptParser

  def self.parse(html_content)
    doc = Nokogiri::HTML(html_content)
    html_lines = doc.css '.caption-line'
    lines = html_lines.map do |line|
      {
        time: time_to_sec(line.css('.caption-line-time').text),
        text: line.css('.caption-line-text').text.strip.gsub("\r\n", ' ')
      }
    end
  end

  def self.time_to_sec(time)
    raise 'Wrong Time Format' unless time =~ /\A(\d+):(\d+)\Z/

    $1.to_i*60 + BigDecimal.new($2)
  end
end
