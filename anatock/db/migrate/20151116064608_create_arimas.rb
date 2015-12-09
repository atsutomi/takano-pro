class CreateArimas < ActiveRecord::Migration
  def change
    create_table :arimas do |t|
      t.integer :num
      t.float :ar1
      t.float :ar2
      t.float :ar3
      t.float :ma1
      t.float :ma2
      t.float :ma3
      t.string :arima_ar
      t.float :intercept
      t.timestamps
    end
  end
end
