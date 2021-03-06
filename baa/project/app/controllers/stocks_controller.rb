# coding: utf-8
class StocksController < ApplicationController
  def index
    @stocks = Stock.all
    @stocks.each do |stock|
      @i = 0
      @page = 0
      while @i < 2 do
        @page += 1
        @stock_news = Nokogiri::HTML(open('http://news.finance.yahoo.co.jp/search/?q='+stock.num.to_s + '&p='+@page.to_s))
    
        #URL取得
        @a_tags = @stock_news.xpath('//div[@class = "marB15 clearFix"]/ul/li/a')
       #title取得
        @news = @stock_news.xpath('//div[@class = "marB15 clearFix"]')
      
        @titles = Array.new
        @urls = Array.new
        
        @newz = News.where(num: stock.num).order("date DESC")
        
        
        #title & url　を抽出してそれぞれの配列に格納
        @a_tags.each do |elm|
          if @newz[0].title == elm.text
            @i = 3
            break
          end
            if !elm.attr('href').include?('/cp/')   #↓
              if !elm.attr('href').include?('.vip') #含まれてなかったら
                if !elm.text.include?("ランキング")   #↑
                  @titles.push(elm.text) #タイトル入れる
                  @urls.push(elm.attr('href')) #url入れてるところ
                  @i = @urls.size
                  if @i == 2
                    break
                  end
                end
              end
            end 
        end
      end
      
      if @i==3
        break
      end
      
  
      @urls.each do |url|
        @news_contet = Nokogiri::HTML(open('http://news.finance.yahoo.co.jp'+url))
        @content = @news_contet.xpath('//div[@id = "richToolTipArea"]/div')
        @test = String(@content.text)
        @acc = 'http://news.finance.yahoo.co.jp'+url
        @sp = url.split("/")[2].split("")
        @date = @sp[0] + @sp[1] + @sp[2] + @sp[3] + "-" + @sp[4] + @sp[5] + "-" + @sp[6] + @sp[7]
      
        @new_news = News.new
        @new_news.num = stock.num
        @new_news.date = @date
        @new_news.content = @test
        @new_news.save
        sleep(2)
      end
    end
    @dbcount =  News.count

    
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
  @doc = Nokogiri::HTML(open('http://info.finance.yahoo.co.jp/ranking/?kd=1&tm=d&vl=a&mk=2&p=1'))
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

