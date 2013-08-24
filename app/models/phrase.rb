class Phrase < ActiveRecord::Base
  validates :name, presence: true
  validates :audio_video_id, presence: true

  scope :by_audio_video, lambda { |audio_video_id|
    where(:audio_video_id => audio_video_id)
  }
end
