class AddGenreToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :genre, :string, limit: 30
    add_index :movies, :genre
  end
end
