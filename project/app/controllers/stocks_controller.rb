# coding: utf-8
class StocksController < ApplicationController
  def index
    @stock = Stock.all
    @news = News.where(stock_no: @stock[50].num ).order(:date)
    
    @oldest = @news[0]
    @newest = @news[@news.size - 1 ]
    
    @doc = Nokogiri::HTML(open('http://info.finance.yahoo.co.jp/history/?code=4335.T&sy=2015&sm=6&sd=7&ey=2015&em=7&ed=7&tm=d'))
    @table = @doc.xpath('//table[@class = "boardFin yjSt marB6"]/tr/td')
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
