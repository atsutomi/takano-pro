class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :num
      t.string :market
      t.string :name
      t.string :business
      t.string :fb
      t.string :tw
      t.string :hp
      t.timestamps
    end
  end
end
