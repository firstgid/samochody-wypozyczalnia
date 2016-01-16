class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :name
      t.string :description
      t.string :car_class

      t.timestamps null: false
    end
  end
end
