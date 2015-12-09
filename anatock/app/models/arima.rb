class Arima < ActiveRecord::Base
  attr_accessible :num, :ar1, :ar2, :ar3, :ma1, :ma2, :ma3, :arima_ar, :intercept
end
