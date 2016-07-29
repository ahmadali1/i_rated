class ChangeDateOfBirthInActors < ActiveRecord::Migration

  def up
    if connection.adapter_name.downcase.starts_with? 'mysql'
      change_column :actors, :date_of_birth, :date
    else
      change_column :actors, :date_of_birth, 'date USING CAST(date_of_birth AS date)'
    end
  end

  def down
    change_column :actors, :date_of_birth, :string, limit: 20
  end

end
