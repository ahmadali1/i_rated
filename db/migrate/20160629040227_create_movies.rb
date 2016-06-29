class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name, null: false, limit: 60
      t.date :released_date, null: false
      t.boolean :is_featured, null: false, default: false
      t.text :description
      t.string :duration, limit: 20
      t.string :embedded_video

      t.timestamps null: false
    end
    add_index :movies, :name
    add_index :movies, :released_date
    add_index :movies, :is_featured
  end

end
