class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :num
      t.string :market
      t.string :name
      t.timestamps
    end
  end
end
