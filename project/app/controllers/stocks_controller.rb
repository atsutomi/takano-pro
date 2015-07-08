# coding: utf-8
require 'date'
class StocksController < ApplicationController
  def index
    @stock = Stock.all
    @i = 0
    while @i < @stock.size-1
      @news = News.where(stock_no: @stock[@i].num ).order(:date)
      @oldest = Date.parse((@news[0].date-10).to_s)
      @newest = Date.parse(@news[@news.size-1].date.to_s)
      @code = @stock[@i].num.to_s
      @page = 0
      
      while @page != null
        @page += 1
        @doc = Nokogiri::HTML(open('http://info.finance.yahoo.co.jp/history//?code='+@code+'&sy='+@oldest.year.to_s+'&sm='+@oldest.month.to_s+'&sd='+@oldest.day.to_s+'&ey='+@newest.year.to_s+'&em='+@newest.month.to_s+'&ed='+@newest.day.to_s+'&tm=d&p='+@page.to_s))
        @table = @doc.xpath('//table[@class = "boardFin yjSt marB6"]/tr/td')
      
        if @table.empty? == false
          @table.each do |table|
          @datas = table.children
          @stock_price = Array.new
          @datas.each do |data|
            @stock_price.push(data.content)
          end
          @prices = Price.new
          @prices.stock_no = @code
          @prices.price = @stock_price[4]
          @prices.date = Date.strptime(@stock_price[0].to_s),'%Y-%m-%d')
          #@prices.save
        end
        else
          break
        end
      end
    end
  end
    

  
  def show
    #@stocks_no = Nokogiri::HTML(open('http://info.finance.yahoo.co.jp/ranking/?kd=1&tm=d&mk=1'))
  
    #@doc = Nokogiri::HTML(open('http://news.finance.yahoo.co.jp/category/stocks/'))
    #URL取得
    #@a_tags = @doc.xpath('//div[@class = "marB15 clearFix"]/ul/li/a')
    #title取得
    #@news = @doc.xpath('//div[@class = "marB15 clearFix"]')
    
    #@titles = Array.new
    #@urls = Array.new
    
    #title & url　を抽出してそれぞれの配列に格納
    #@a_tags.each do |elm|
    #  @titles.push(elm.text)
    #  @urls.push(elm.attr('href'))
    #end
    
  end
  
  
  #Python呼び出し
   #IO.popen("python /home/ne25-0010e/test.py "+@a.to_s+' '+@b.to_s).each do |line|
   #@news=line.chomp
   # end
  


end
