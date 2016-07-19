class AddDeltaToMovies < ActiveRecord::Migration

  def up
    add_column :movies, :delta, :boolean, default: true, null: false
  end

  def down
    remove_column :movies, :delta
  end

end
