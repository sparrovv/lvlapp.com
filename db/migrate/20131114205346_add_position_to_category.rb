class AddPositionToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :slug, :string
    add_column :categories, :position, :integer, default: 0
    add_index  :categories, :slug, unique: true
  end
end
