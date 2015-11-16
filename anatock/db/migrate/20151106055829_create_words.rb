class CreateWords < ActiveRecord::Migration
  def change
    create_table(:words, :id => false) do |t|
      t.integer :num
      t.date :date
      t.integer :A
      t.integer :B
      t.integer :C
      t.integer :D
      t.integer :E
      t.integer :F
      t.integer :G
      t.integer :H
      t.integer :I
      t.integer :J
      t.integer :K
      t.integer :L
      t.integer :M
      t.integer :N
      t.integer :O
      t.integer :P
      t.integer :Q
      t.integer :R
      t.integer :S
      t.integer :T
      
      t.timestamps
    end
  end
end
