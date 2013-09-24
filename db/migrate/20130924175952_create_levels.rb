class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :name

      t.timestamps
    end

    add_column :audio_videos, :level_id, :integer
    add_index :audio_videos, :level_id
  end
end
