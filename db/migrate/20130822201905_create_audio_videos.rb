class CreateAudioVideos < ActiveRecord::Migration
  def change
    create_table :audio_videos do |t|
      t.string :name
      t.text :description
      t.text :transcript
      t.string :url
      t.integer :length

      t.timestamps
    end
  end
end
