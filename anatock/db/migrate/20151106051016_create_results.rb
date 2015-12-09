class CreateResults < ActiveRecord::Migration
  def change
    create_table(:results, :id => false) do |t|
      t.integer :num
      t.date :date
      t.float :prob
      t.float :ratio

      t.timestamps
    end
  end
end
