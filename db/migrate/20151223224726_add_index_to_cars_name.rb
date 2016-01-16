class AddIndexToCarsName < ActiveRecord::Migration
  def change
    add_index :cars, :name, unique: true
  end
end
