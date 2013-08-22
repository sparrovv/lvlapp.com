class AudioVideo < ActiveRecord::Base
  validates :name, presence: true
  validates :transcript, presence: true
  validates :url, presence: true
end
