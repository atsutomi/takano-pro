#coding: utf-8

class StocksController < ApplicationController
  def index
    @stock_order = Stock.order("num")
    @stocks = @stock_order.paginate(:page => params[:page], :per_page => 20)
  end
  
  def search1
    @stock_order = Stock.order("num")
    @search_stocks = @stock_order.msearch(params[:q])
    @search_stocks = @search_stocks.bsearch(params[:r])
    @stocks = @search_stocks.paginate(:page => params[:page], :per_page => 20)
    render "index"
  end
  
  def search2
    @stock_order = Stock.order("num")
    @search_stocks = @stock_order.search(params[:s])
    @stocks = @search_stocks.paginate(:page => params[:page], :per_page => 20)
    render "index"
  end
  
  def show
    @stock = Stock.find(params[:id])
    #Python呼び出し
    IO.popen("python arima.py "+@stock.num.to_s)
    sleep(0.5)
    @prices = Price.where(num: @stock.num).order("date DESC")
    #@value = Result.where(num: @stock.num)
    @category = [@prices[6].date, @prices[5].date, @prices[4].date,
                @prices[3].date, @prices[2].date, @prices[1].date, @prices[0].date, @prices[0].date+1]
    @current_quantity = [@prices[6].sprice, @prices[5].sprice, @prices[4].sprice,
                        @prices[3].sprice, @prices[2].sprice, @prices[1].sprice, @prices[0].sprice]
    @uprange = [nil,nil,nil,nil,nil,nil,@prices[0].sprice,@prices[1].sprice]
                        
    
    @graph = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '週間推移')
      f.xAxis(categories: @category)
      f.series(name: "aa" , data: @uprange)
      f.series(name: "株価" , data: @current_quantity)
    end
    
    
  
  end
  
  
  
end
