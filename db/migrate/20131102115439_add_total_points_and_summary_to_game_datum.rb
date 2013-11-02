class AddTotalPointsAndSummaryToGameDatum < ActiveRecord::Migration
  def change
    add_column :game_data, :total_points, :integer
    add_column :game_data, :summary, :text
    add_index  :game_data, :total_points
  end
end
