class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :stock_no
      t.string :market
      t.string :name
      t.float :price
      t.timestamps
    end
  end
end
