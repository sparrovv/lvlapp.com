class User < ActiveRecord::Base
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
end
