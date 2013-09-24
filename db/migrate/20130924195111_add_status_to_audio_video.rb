class AddStatusToAudioVideo < ActiveRecord::Migration
  def change
    add_column :audio_videos, :status, :string
    add_index :audio_videos, :status
  end
end
