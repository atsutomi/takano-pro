#coding: utf-8

class StocksController < ApplicationController
  def index
    @stocks = Stock.paginate(:page => params[:page], :per_page => 20)
  end
  
  def search
    @search_stocks = Stock.search(params[:q])
    @stocks = @search_stocks.paginate(:page => params[:page], :per_page => 20)
    render "index"
  end
  
  def show
    @stock = Stock.find(params[:id])
    @prices = Price.where(num: @stock.num).order("date DESC")
    category = [@prices[6].date, @prices[5].date, @prices[4].date,
                @prices[3].date, @prices[2].date, @prices[1].date, @prices[0].date]
    current_quantity = [@prices[6].sprice, @prices[5].sprice, @prices[4].sprice,
                        @prices[3].sprice, @prices[2].sprice, @prices[1].sprice, @prices[0].sprice]

    @graph = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '週間推移')
      f.xAxis(categories: category)
      f.series(name: "株価" , data: current_quantity)
    end
  end
  
  
  
end
