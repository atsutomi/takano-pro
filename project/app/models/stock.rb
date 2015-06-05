class Stock < ActiveRecord::Base
  attr_accessible :stock_no, :market, :name, :price
end
