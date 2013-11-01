class Phrase < ActiveRecord::Base
  AudioVideoPhrase = Struct.new(:size, :due_to_repetition, :audio_video)
  serialize :definition, JSON
  serialize :examples, JSON
  serialize :related, JSON

  validates :name, presence: true
  validates :audio_video_id, presence: true

  belongs_to :audio_video
  belongs_to :user

  scope :by_audio_video, lambda { |audio_video_id|
    where(audio_video_id: audio_video_id)
  }

  scope :by_user, lambda { |user|
    where(user: user)
  }

  def self.grouped_by_audio_video(user)
    results = self.by_user(user).count(group: 'audio_video_id')

    results.inject([]) do |foo, (audio_video_id, size)|
      audio_video = AudioVideo.find(audio_video_id)
      foo << AudioVideoPhrase.new(size, self.due_to_repetition(user,audio_video), audio_video)
      foo
    end
  end

  def repetition_date_js
    return nil unless repetition_date

    repetition_date.to_time.to_i * 1000
  end

  def sentence=(line)
    line = line[0..254] if line.to_s.size > 255
    super(line)
  end

  def self.due_to_repetition(user, audio_video)
    self.by_user(user).
      by_audio_video(audio_video).
      where("repetition_date <= ? OR repetition_date is null", Date.today).
      count
  end
end
