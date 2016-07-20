class AddApprovedToMovies < ActiveRecord::Migration

  def up
    add_column :movies, :approved, :boolean, default: false
  end

  def down
    remove_column :movies, :approved
  end

end
