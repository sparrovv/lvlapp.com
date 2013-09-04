class AudioVideo < ActiveRecord::Base
  validates :name, presence: true
  validates :transcript, presence: true
  validates :url, presence: true

  def youtube?
    !!url.match(/youtube/i)
  end

  def transcript_in_hash
    JSON.parse(transcript).map{ |t|
      t['time'] = BigDecimal(t['time'])
      t
    }
  end
end
