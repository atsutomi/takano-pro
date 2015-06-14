class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.integer :stock_no
      t.date :date
      t.string :content
      t.timestamps
    end
  end
end
