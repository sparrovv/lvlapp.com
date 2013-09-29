class GameDatum < ActiveRecord::Base
  belongs_to :user
  belongs_to :audio_video

  [:user, :audio_video, :blanks, :guessed, :skipped, :mistakes, :time, :level].each do |field|
    validates field, presence: true
  end
end
