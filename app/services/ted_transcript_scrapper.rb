require 'nokogiri'
require 'json'
require 'open-uri'

class TedTranscriptScrapper
  def self.getFromHtml(transcript_url, ted_transcript_shift)
    file = open(transcript_url)
    doc = Nokogiri::HTML(file.read)
    a_elements = doc.css 'a'

    text_time = a_elements.map {|e|
      {
        time: e.attr('href').gsub('#', '').to_i/1000 + ted_transcript_shift,
        text: e.text
      }
    }

    text_time.to_json
  end

end
