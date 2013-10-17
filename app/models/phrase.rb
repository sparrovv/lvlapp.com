class Phrase < ActiveRecord::Base
  serialize :definition, JSON
  serialize :examples, JSON
  serialize :related, JSON

  validates :name, presence: true
  validates :audio_video_id, presence: true

  belongs_to :audio_video
  belongs_to :user

  scope :by_audio_video, lambda { |audio_video_id|
    where(:audio_video_id => audio_video_id)
  }

  def singularize_phrase
    self.name = name.singularize
    self
  end

  def repetition_date_js
    return nil unless repetition_date

    repetition_date.to_time.to_i * 1000
  end

  def sentence=(line)
    line = line[0..254] if line.to_s.size > 255
    super(line)
  end
end
