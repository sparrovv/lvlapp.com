class CreatePhrases < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
      t.string :name
      t.integer :audio_video_id
      t.text :definition
      t.text :examples
      t.string :translation

      t.timestamps
    end
  end
end
