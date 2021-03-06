class User < ActiveRecord::Base
  include Gravtastic
  gravtastic

  OTHER_NATIVE_LANG = 'other'
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :native_language, presence: true

  has_many :phrases
  has_many :game_data

  def phrases_by_audio_video(audio_video)
    phrases.where(audio_video: audio_video)
  end

  def username
    email[/(.+)@/,1]
  end

  def points
    game_data.sum('total_points')
  end
end
