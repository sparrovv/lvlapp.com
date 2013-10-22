class AddFeaturedFlag < ActiveRecord::Migration
  def change
    add_column :audio_videos, :featured, :boolean
    add_index :audio_videos, :featured
  end
end
