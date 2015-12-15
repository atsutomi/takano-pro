#coding: utf-8

class Tasks::SpriceTask
  def self.execute
  
    @stocks = Stock.all
    @pcount = 0
    @count = 0
    @stocks.each do |stock|
      
#ニュース取得
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
          if @newz.count > 0
            if @newz[0].title == elm.text
            @i = 3
            break
            end
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
      
      @urls.zip(titles).each do |url,title|
        @news_contet = Nokogiri::HTML(open('http://news.finance.yahoo.co.jp'+url))
        @content = @news_contet.xpath('//div[@id = "richToolTipArea"]/div')
        @test = String(@content.text)
        @acc = 'http://news.finance.yahoo.co.jp'+url
        @sp = url.split("/")[2].split("")
        @date = @sp[0] + @sp[1] + @sp[2] + @sp[3] + "-" + @sp[4] + @sp[5] + "-" + @sp[6] + @sp[7]
      
        @new_news = News.new
        @new_news.num = stock.num
        @new_news.date = @date
        @new_news.title = title
        @new_news.contents = @test
        @new_news.url = url
        @new_news.save
        sleep(2)
      end

#株価取得
      @count += 1
      #print stock.num
    
      #@news = News.where(stock_no: stock.num ).order(:date)
      @old = Price.find(:first, :order => "date DESC" ,:conditions => {:num => stock.num})
      #.wday == 0(日曜) 6(月曜)
     
      @newest = Date.today
      @oldest = @old.date + 1
      print @newest.to_s + "\n"
      print @oldest.to_s + "\n"
      #case @oldest.wday
      #when 0
      #  @oldest -= 2
      #when 6
      #  @oldest -= 1
      #end
      
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
        for @ida in 1..(@table.size-1) do
          @tabledata = @table[@ida].xpath('td')
          if @tabledata.size == 7
            @price = Price.new
            @price.num = stock.num
            @price.date = Date.strptime((@tabledata[0].text), '%Y年%m月%d日')
            @price.start = @tabledata[1].text.delete(",").to_f
            @price.high = @tabledata[2].text.delete(",").to_f
            @price.low = @tabledata[3].text.delete(",").to_f
            @price.sprice = @tabledata[4].text.delete(",").to_f
            @price.volume = @tabledata[5].text.delete(",").to_f
            @price.aprice = @tabledata[6].text.delete(",").to_f
            @price.save           
          end 
        end
        
        
      end
      
      @today = Date.today
      IO.popen("python result_table.py "+stock.num.to_s+" "+@today.to_s)
      print @count.to_s + "\n"
    end
    
    
    
  end
end