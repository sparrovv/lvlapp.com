class AudioVideo < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  ACTIVE = 'active'
  PENDING = 'pending'
  INACTIVE = 'inactive'

  STATUSES = [PENDING, ACTIVE, INACTIVE]

  after_initialize :init

  validates :name, presence: true
  validates :transcript, presence: true
  validates :url, presence: true
  validates :category, presence: true
  validates :level, presence: true
  validates :status, presence: true, inclusion: STATUSES
  validate :validate_json_format
  validate :validate_space_after_period_and_comma

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
  scope :featured, -> { where(featured: true) }

  delegate :name, to: :level, :prefix => true, :allow_nil => true
  delegate :name, to: :category, :prefix => true, :allow_nil => true

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
  def validate_json_format
    return true unless transcript.present?
    JSON.parse transcript
  rescue JSON::ParserError => e
    errors.add(:transcript, 'Invalid JSON: ' + e.message)
  end

  def validate_space_after_period_and_comma
    return true unless transcript.present?
    parsed = JSON.parse transcript
    text_array = parsed.map { |r| r['text']}
    text_array.each do |text|
      if text.match(/[a-z][,\.][a-z]/i)
        errors.add(:transcript, 'there is no space after . or , at line ' + text)
      end
    end
  rescue JSON::ParserError => e
  end
end
