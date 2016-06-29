class CreateMovieCasts < ActiveRecord::Migration
  def change
    create_table :movie_casts do |t|
      t.references :movie, index: true, foreign_key: true, null: false
      t.references :actor, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
