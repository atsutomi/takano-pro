class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :num
      t.string :market
      t.string :name
      t.string :price
      t.date :date
      t.timestamps
    end
  end
end
