#coding: utf-8

class Tasks::SpriceRegister
  def self.execute
    
    @stocks = Stock.all
    @pcount = 0
    @count = 0
    @stocks.each do |stock|
    
    
      
      #@news = News.where(stock_no: stock.num ).order(:date)
      @old = Price.find(:first, :order => "date DESC" ,:conditions => {:num => stock.num})
      #.wday == 0(日曜) 6(月曜)
      if @count == 2
        break
      end
      @count += 1
      
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
        for @i in 1..(@table.size-1) do
          @pcount +=1
          @tabledata = @table[@i].xpath('td')
          if @tabledata.size == 7
            @price = Price.new
            @price.num = stock.num
            @price.sprice = @tabledata[4].text.delete(",").to_f
            @price.date = Date.strptime((@tabledata[0].text), '%Y年%m月%d日')
            #print @price.stock_no
            #@price.save
            
=begin
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
=end            
          end
          
          
        end
      end
      print @count.to_s + "\n"
    end
    
    
    
  end
end