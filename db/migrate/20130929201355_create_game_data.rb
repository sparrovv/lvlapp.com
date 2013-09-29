class CreateGameData < ActiveRecord::Migration
  def change
    create_table :game_data do |t|
      t.integer :user_id
      t.integer :audio_video_id
      t.integer :blanks
      t.integer :guessed
      t.integer :skipped
      t.integer :mistakes
      t.integer :time
      t.string :level

      t.timestamps
    end

    add_index :game_data, [:user_id, :audio_video_id]
  end
end
