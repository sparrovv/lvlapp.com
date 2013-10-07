class AddViewsCountMigration < ActiveRecord::Migration
  def change
    add_column :audio_videos, :views_count, :integer, default: 0
    add_index :audio_videos, :views_count
  end
end
