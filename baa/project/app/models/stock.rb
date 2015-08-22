class Stock < ActiveRecord::Base
  attr_accessible :num, :market, :name, :price, :date
end
