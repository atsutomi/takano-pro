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
  end
  
  def page
    @pages = [1,2,3,4,5]
    @page = params[:id]
    @pagei = @page.to_i
    @count = 20 * (@page.to_i - 1)
    @stocks = Stock.order("num")
    @Pstocks2 = @stocks.offset(@count)
    @Pstocks = @Pstocks2.limit(20)
    @market = Stock.select("market").uniq
    if 3 < @pagei
      @n = @pagei -2
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
