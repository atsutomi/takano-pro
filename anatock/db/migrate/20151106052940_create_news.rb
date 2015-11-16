class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.integer :num
      t.date :date
      t.string :title
      t.string :contents
      t.string :url


      t.timestamps
    end
  end
end
