class AddRelatedWords < ActiveRecord::Migration
  def change
    add_column :phrases, :related, :string
  end
end
