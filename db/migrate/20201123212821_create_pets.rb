class CreatePets < ActiveRecord::Migration[6.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.date :found_date
      t.string :description
      t.string :species
      t.string :breed
      t.string :size
      t.string :age
      t.string :state
      t.string :city
      t.string :neighborhood
      t.boolean :adopted

      t.timestamps
    end
  end
end
