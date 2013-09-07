class AddUserIdToPhrases < ActiveRecord::Migration
  def change
    add_column :phrases, :user_id, :integer
    add_index :phrases, :user_id
  end
end
