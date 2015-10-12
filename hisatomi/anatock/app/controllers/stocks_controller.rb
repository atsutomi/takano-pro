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
  end

end
