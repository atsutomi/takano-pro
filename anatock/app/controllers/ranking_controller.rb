#coding: utf-8

class RankingController < ApplicationController
  def index
    @stocks = Stock.limit(10)
    
    #<div id="graph" ><%= high_chart("sample", @graph) %></div>
    
    @s = Stock.find(1000)
    
    @category = Array.new
    @current_quantity = Array.new
    
    @stocks.each do |stock|
      @prices = Price.where(num: stock.num).order("date DESC")
      
      @category.push(stock.name)
      @current_quantity.push(@prices[0].sprice)
    end
    
   
    
    @graph = LazyHighCharts::HighChart.new('graph') do |f|
      f.chart(type: 'bar')
      f.title(text: 'Top10')
      f.xAxis(categories: @category)
      f.series(name: "株価" , data: @current_quantity)
    end
  
  end
  def sort
    
  end

end
