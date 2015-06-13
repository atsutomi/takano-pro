# coding: utf-8
class StocksController < ApplicationController
  def index
    @stock = Stock.all
    @ac = @stock[0].num.to_s
    @i = 0
    @page = 0
    while @i < 5 do
      @page += 1
      @stock_news = Nokogiri::HTML(open('http://news.finance.yahoo.co.jp/search/?q='+@stock[0].num.to_s + '&p='+@page.to_s))
  
      #URL取得
      @a_tags = @stock_news.xpath('//div[@class = "marB15 clearFix"]/ul/li/a')
     #title取得
      @news = @stock_news.xpath('//div[@class = "marB15 clearFix"]')
    
      @titles = Array.new
      @urls = Array.new
    
      #title & url　を抽出してそれぞれの配列に格納
      @a_tags.each do |elm|
          if !elm.attr('href').include?('/cp/')
            if !elm.attr('href').include?('.vip')
              if !elm.text.include?("ランキング")
                @urls.push(elm.attr('href'))
                @titles.push(elm.text)
                @i += 1
                if @i == 5
                  break
                end
              end
            end
          end 
      end
    end
    
    @urls.each do |url|
      @news_contet = Nokogiri::HTML(open('http://news.finance.yahoo.co.jp'+url))
      @content = @news_contet.xpath('//div[@id = "richToolTipArea"]/div')
      @acc = 'http://news.finance.yahoo.co.jp'+url
    end
 

  
  #こっから上のコメントアウト消す
  
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
  
=begin
   #銘柄５０件DB格納
    @doc = Nokogiri::HTML(open('http://info.finance.yahoo.co.jp/ranking/?kd=1&tm=d&mk=1'))
  @ranking = @doc.xpath('//tr[@class = "rankingTabledata yjM"]')
  @ranking.each do |ranking|
    @datas = ranking.children
    @stock_data = Array.new
    @datas.each do |data|
      @stock_data.push(data.content)
    end
      @stock = Stock.new
      @stock.num = @stock_data[1]
      @stock.market = @stock_data[2]
      @stock.name = @stock_data[3]
      @stock.price = @stock_data[5]
      @stock.date = Date.today
      @stock.save
    end
=end
end

