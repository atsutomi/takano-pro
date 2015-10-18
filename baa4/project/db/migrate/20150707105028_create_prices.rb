class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :stock_no
      t.float :price
      t.date :date
      t.timestamps
    end
  end
end
