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
end
