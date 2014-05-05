require 'json'
require 'open-uri'

class TedTranscriptScrapper
  def self.from_json(transcript_url, ted_transcript_shift)
    file = open(transcript_url)
    doc = JSON.parse(file.read)

    text_time = doc['captions'].map {|e|
      {
        time: e['startTime'].to_i/1000 + ted_transcript_shift,
        text: e['content']
      }
    }

    text_time.to_json
  end
end
