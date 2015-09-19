class StocksController < ApplicationController
  def index
    @stock = Stock.find(1)
  end
  
  def show
    @stock = Stock.find(2)
  end
end
