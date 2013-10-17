class AudioVideo < ActiveRecord::Base
  ACTIVE = 'active'
  PENDING = 'pending'

  STATUSES = [PENDING, ACTIVE]

  after_initialize :init

  validates :name, presence: true
  validates :transcript, presence: true
  validates :url, presence: true
  validates :category, presence: true
  validates :level, presence: true
  validates :status, presence: true, inclusion: STATUSES

  belongs_to :category
  belongs_to :level

  scope :by_category, lambda { |category|
    if category
      where(category_id: category.id)
    else
      all
    end
  }

  scope :by_status, lambda { |status|
    where(status: status)
  }

  scope :popular, -> { where("views_count > 0").order("views_count DESC") }
  delegate :name, to: :level, :prefix => true, :allow_nil => true

  def youtube?
    !!url.match(/youtube/i)
  end

  def tedtalk?
    !!url.match(/ted\.com/i)
  end

  def transcript_in_hash
    JSON.parse(transcript).map{ |t|
      t['time'] = BigDecimal(t['time'].to_s)
      t
    }
  end

  private
  def init
    self.status ||= PENDING
  end
end
