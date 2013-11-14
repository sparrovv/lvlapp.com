class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  validates :name, presence: true, uniqueness: true
  validates :position, presence: true
  has_many :audio_videos
end
