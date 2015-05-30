class StocksController < ApplicationController
  def index
    @doc = Nokogiri::HTML(open('http://info.finance.yahoo.co.jp/ranking/?kd=1&tm=d&mk=1'))
    @ranking = @doc.xpath('//tr[@class = "rankingTabledata yjM"]')
    @stock = @ranking[1].children
    @stock_data = Array.new
    @stock.each do |data|
      @stock_data.push(data.content)
    end
    #URL取得
    #@elms = @doc.xpath('//tr[@class = "rankingTabledata yjM"]/td[@class = "txtcenter"]/a')
    #@urls = Array.new
    #@elms.each do |elm|
    #  @urls.push(elm.attr('href'))
    #end
  end
  
  def show
    #@news = Nokogiri::HTML(open('http://news.finance.yahoo.co.jp/search/?q=4661'))
    @a = 2
    @b = 3
    RubyPython.start
     
    RubyPython.stop
  end
end
