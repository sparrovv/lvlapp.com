class AudioVideo < ActiveRecord::Base
  LEVEL = ['easy', 'medium', 'hard']

  validates :name, presence: true
  validates :transcript, presence: true
  validates :url, presence: true
  validates :category, presence: true

  belongs_to :category

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
