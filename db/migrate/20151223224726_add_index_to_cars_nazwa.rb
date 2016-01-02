class AddIndexToCarsNazwa < ActiveRecord::Migration
  def change
    add_index :cars, :nazwa, unique: true
  end
end
