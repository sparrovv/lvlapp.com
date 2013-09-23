class GenerateCategoryModel < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    add_index :categories, :name, :unique => true

    add_column :audio_videos, :category_id, :integer
    add_index :audio_videos, :category_id
  end
end
