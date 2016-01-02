class CreateTermins < ActiveRecord::Migration
  def change
    create_table :termins do |t|
      t.string :osoba
      t.references :car, :index => true, :foreign_key => true
      t.integer :cena
      t.date :data_wyp
      t.date :data_odd

      t.timestamps null: false
    end
  end
end
