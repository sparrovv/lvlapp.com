class GameDatum < ActiveRecord::Base
  serialize :summary, JSON

  belongs_to :user
  belongs_to :audio_video

  [:total_points, :user, :audio_video, :blanks, :guessed, :skipped, :mistakes, :time, :level].each do |field|
    validates field, presence: true
  end
end
