class ChangeScoreInRatings < ActiveRecord::Migration

  def up
    change_column :ratings, :score, :integer, default: 0, null: false
  end

  def down
    change_column :ratings, :score, :integer, default: 0
  end

end
