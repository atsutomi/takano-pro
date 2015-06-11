class StocksController < ApplicationController
  def index
    @doc = Nokogiri::HTML(open('http://info.finance.yahoo.co.jp/ranking/?kd=1&tm=d&mk=1'))
    
    
    
    
    
    
    #URL取得
    #@elms = @doc.xpath('//tr[@class = "rankingTabledata yjM"]/td[@class = "txtcenter"]/a')
    #@urls = Array.new
    #@elms.each do |elm|
    #  @urls.push(elm.attr('href'))
    #end
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
  
  
  #銘柄５０件DB格納
  #@ranking = @doc.xpath('//tr[@class = "rankingTabledata yjM"]')
  #@ranking.each do |ranking|
  #   @datas = ranking.children
  # @datas.each do |data|
  #    @stock_data.push(data.content)
  #    end
  #    @stock = Stock.new
  #    @stock.stock_no = @stock_data[1]
  #    @stock.market = @stock_data[2]
  #    @stock.name = @stock_data[3]
  #    @stock.price = @stock_data[5]
  #    @stock.save
  #  end
  
  
  
  
  
  
  
end
