class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.integer :num
      t.date :date
      t.string :title
      t.text :contents
      t.string :url


      t.timestamps
    end
  end
end
