require 'nokogiri'
require 'json'
require 'open-uri'

class TedTranscriptScrapper
  # visit the video page
  #   web-console: talkDetails.mediaPad
        # it can be 11.82 or 15.33 or ...
  #   choose: transcript check the url (http://www.ted.com/talks/subtitles/id/848/lang/en/format/html)

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
