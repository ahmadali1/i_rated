class ChangeDateOfBirthInActors < ActiveRecord::Migration

  def up
    change_column :actors, :date_of_birth, :date
  end

  def down
    change_column :actors, :date_of_birth, :string, limit: 20
  end

end
