class AudioVideo < ActiveRecord::Base
  validates :name, presence: true
  validates :transcript, presence: true
  validates :url, presence: true
  validates :category, presence: true
  validates :level, presence: true

  belongs_to :category
  belongs_to :level

  scope :by_category, lambda { |category|
    if category
      where(category_id: category.id)
    else
      scoped
    end
  }
  delegate :name, to: :level, :prefix => true, :allow_nil => true

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
