class AddBiographyToActors < ActiveRecord::Migration

  def up
    add_column :actors, :biography, :text, limit: 2000
  end

  def down
    remove_column :actors, :biography
  end

end
