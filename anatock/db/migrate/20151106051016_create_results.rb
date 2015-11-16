class CreateResults < ActiveRecord::Migration
  def change
    create_table(:results, :id => false) do |t|
      t.integer :num
      t.date :date
      t.float :logi
      t.float :arima
      t.float :svm
      t.float :rf
      t.float :infw
      t.float :logiarima

      t.timestamps
    end
  end
end
