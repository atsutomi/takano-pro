#coding: utf-8

class StocksController < ApplicationController
  def index
    @stock = Stock.find(1)
  end
  
  def show
    @stock = Stock.find(2)
  
  
  
  
    category = ["2015-10-02","2015-10-03","2015-10-04","2015-10-05","2015-10-06","2015-10-07","2015-10-08"]
    current_quantity = [1000,5000,3000,8000,4000,7000,6000]

    @graph = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '週間推移')
      f.xAxis(categories: category)
      f.series(name: "株価" , data: current_quantity)
      
      
      
    end
  end
end
