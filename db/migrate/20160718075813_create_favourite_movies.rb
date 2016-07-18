class CreateFavouriteMovies < ActiveRecord::Migration
  def change
    create_table :favourite_movies do |t|
      t.references :user, index: true, foreign_key: true
      t.references :movie, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
