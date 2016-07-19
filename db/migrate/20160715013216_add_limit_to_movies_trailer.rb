class AddLimitToMoviesTrailer < ActiveRecord::Migration

  def up
    change_column :movies, :embedded_video, :string, limit: 250
  end

  def down
    change_column :movies, :embedded_video, :string
  end

end
