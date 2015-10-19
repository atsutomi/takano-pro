# coding: utf-8
class RankingController < ApplicationController
  def index
    @stocks = Stock.all
    @pcount = 0
    @stocks.each do |stock|
      
      @newest = Date.new(2015, 10, 16)
      @oldest = @newest - 300
      
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
            @price.date = Date.strptime((@tabledata[0].text), '%Y年%m月%d日')
            @price.start = @tabledata[1].text.delete(",").to_f
            @price.high = @tabledata[2].text.delete(",").to_f
            @price.low = @tabledata[3].text.delete(",").to_f
            @price.sprice = @tabledata[4].text.delete(",").to_f
            @price.volume = @tabledata[5].text.delete(",").to_f
            @price.save          
          end     
        end
      end
    end
  end
end