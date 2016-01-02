class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :nazwa
      t.string :opis
      t.string :klasa

      t.timestamps null: false
    end
  end
end
