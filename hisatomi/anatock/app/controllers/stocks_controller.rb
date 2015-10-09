#coding: utf-8

class StocksController < ApplicationController
  def index
    @page = 1
    @pages = [1,2,3,4,5]
    @stocks = Stock.order("num")
    @Pstocks = @stocks.limit(20)
    @market = Stock.select("market").uniq
  end
  
  
  def search
    @Pstocks = Stock.search(params[:q])
    @market = Stock.select("market").uniq
    @pages = [1,2,3,4,5]
    render "index"
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
  
  def page
    @pages = [1,2,3,4,5]
    @page = params[:id]
    @pagei = @page.to_i
    if 0 < @pagei
    @count = 20 * (@page.to_i - 1)
    @stocks = Stock.order("num")
    @Pstocks2 = @stocks.offset(@count)
    @Pstocks = @Pstocks2.limit(20)
    @market = Stock.select("market").uniq
    else
    @pagei = 1
    @count = 20 * (@page.to_i - 1) 
    @stocks = Stock.order("num")
    @Pstocks = @stocks.offset(@count).limit(20)
    #@Pstocks = @Pstocks2.limit(20)
    @market = Stock.select("market").uniq
    end
    
    if 3 < @pagei
      @n = @pagei - 2
      for @i in 1..5 do
        @pages[@i-1] = @n
        @n += 1
      end
    else
      @n = 1
      for @i in 1..5 do
        @pages[@i-1] = @n
        @n += 1
      end
    end
    render "index"
  end
  
end
