class AddSentenceToPhrases < ActiveRecord::Migration
  def change
    add_column :phrases, :sentence, :string
  end
end
