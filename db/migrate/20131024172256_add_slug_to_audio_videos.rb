class AddSlugToAudioVideos < ActiveRecord::Migration
  def change
    add_column :audio_videos, :slug, :string
    add_index  :audio_videos, :slug, unique: true
  end
end
