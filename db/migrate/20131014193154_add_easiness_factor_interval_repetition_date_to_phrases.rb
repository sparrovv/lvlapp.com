class AddEasinessFactorIntervalRepetitionDateToPhrases < ActiveRecord::Migration
  def change
    add_column :phrases, :interval, :integer
    add_column :phrases, :easiness_factor, :float
    add_column :phrases, :repetition_date, :date
  end
end
