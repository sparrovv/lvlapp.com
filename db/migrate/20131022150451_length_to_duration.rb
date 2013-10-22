class LengthToDuration < ActiveRecord::Migration
  def change
    rename_column :audio_videos, :length, :duration
    change_column :audio_videos, :duration, :decimal, :precision => 16, :scale => 2
  end
end
