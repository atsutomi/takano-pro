# coding: utf-8
class StocksController < ApplicationController
  def index
  
    @stocks = Stock.all
    @stocks.each do |stock|
      
      @news = News.where(stock_no: stock.num ).order(:date)
      #.wday == 0(日曜) 6(月曜)
      if news.size > 0
        @oldest = Date.parse((@news[0].date-10).to_s)
        @newest = Date.parse(@news[@news.size-1].date.to_s)
      else
        @oldest = Date.new(2015, 6 ,19)
        @newest = Date.new(2007, 6 ,29)
      end
      
      
      
      case @oldest.wday
      when 0
        @oldest -= 2
      when 6
        @oldest -= 1
      end
      
      @days = (@newest - @oldest).to_i #ニュース最新と最古からの期間
      @page = 0
      @warizan = @days/20
      @amari = @days%20
  
      @max = 0
      if @amari > 0
        @max = @warizan + 1
      else
        @max = @warizan
      end

      while @page < @max do
        sleep(4)
        @page += 1
        @stock_value = Nokogiri::HTML(open('http://info.finance.yahoo.co.jp/history/?code='+stock.num.to_s+'.T&sy='+@oldest.year.to_s+'&sm='+@oldest.month.to_s+'&sd='+@oldest.day.to_s+'&ey='+@newest.year.to_s+'&em='+@newest.month.to_s+'&ed='+@newest.day.to_s+'&tm=d&p='+@page.to_s))
        @table = @stock_value.xpath('//table[@class = "boardFin yjSt marB6"]/tr')
        for @i in 1..(@table.size-1) do
          @tabledata = @table[@i].xpath('td')
          if @tabledata.size == 7
            @price = Price.new
            @price.stock_no = stock.num
            @price.price = @tabledata[4].text.delete(",").to_f
            @price.date = Date.strptime((@tabledata[0].text), '%Y年%m月%d日')
            @price.save
            if Date.strptime((@tabledata[0].text),'%Y年%m月%d日').wday == 5
              @price = Price.new
              @price.stock_no = stock.num
              @price.price = @tabledata[4].text.delete(",").to_f
              @price.date = Date.strptime((@tabledata[0].text), '%Y年%m月%d日') + 1
              @price.save
            
              @price = Price.new
              @price.stock_no = stock.num
              @price.price = @tabledata[4].text.delete(",").to_f
              @price.date = Date.strptime((@tabledata[0].text), '%Y年%m月%d日') + 2
              @price.save
            end
          end
          
          
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




end

#↓不要コード
  
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

        #title & url　を抽出してそれぞれの配列に格納
    
=begin
        @a_tags.each do |elm|
            if !elm.attr('href').include?('/cp/')   #↓
              if !elm.attr('href').include?('.vip') #含まれてなかったら
                if !elm.text.include?("ランキング")   #↑
                  @urls.push(elm.attr('href')) #url入れてるところ
                  @titles.push(elm.text) #タイトル入れる
                  @i = @urls.size
                  if @i == 5
                    break
                  end
                end
              end
            end 
        end
    
=end
