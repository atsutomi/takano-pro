class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :num
      t.date :date
      t.float :start
      t.float :high
      t.float :low
      t.float :sprice
      t.float :volume
      t.timestamps
    end
  end
end
