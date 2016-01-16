class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :person
      t.references :car, :index => true, :foreign_key => true
      t.integer :price
      t.date :date_of_rent
      t.date :date_of_return

      t.timestamps null: false
    end
  end
end
