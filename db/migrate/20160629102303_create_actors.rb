class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string :name, null: false, limit: 60
      t.integer :age
      t.string :country, limit: 20
      t.string :gender
      t.string :date_of_birth, limit: 20

      t.timestamps null: false
    end
  end
end
