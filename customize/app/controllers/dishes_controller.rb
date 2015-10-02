#coding : utf-8
class DishesController < ApplicationController
  def index    
    @dishes = Dish.all
    if(session[:status] != nil)
      @dishes = Dish.where(category: session[:status])
    else
      @dishes = Dish.all
    end
  end
  
  def top
    session.delete(:status)
    session.delete(:order)
    @dishes = Dish.all
    if(session[:status] != nil)
      @dishes = Dish.where(category: session[:status])
    else
      @dishes = Dish.all
    end
    render "index"
  end

  def show
    @dish = Dish.find(params[:id])
    if params[:format].in?(["jpg", "png", "gif"])
      send_image
    else
      render "dishes/show"
    end
  end

  def search
      @minus = params[:minus]
      @dishes = Dish.all
      if @minus
        @minus.each do |minus|
          @dishes.delete_if do |dish|
            @foodstuffs_name = Array.new
            dish.foodstuffs.each do |foodstuff|
              @foodstuffs_name.push(foodstuff.name.to_s)
            end
            @foodstuffs_name.include?(minus)
          end
        end
      else
        @dishes = Dish.search(params[:q])
      end
    render "index"
  end

  def order
    @dish = Dish.find(params[:id])
    session[session[:status]] = @dish
    case @dish.category
      when "staple"
        session[:order].staple_id = @dish.id
      when "main"
        session[:order].main_id = @dish.id
      when "sub"
        session[:order].sub_id = @dish.id
    end
    redirect_to :controller=>"orders", :action=>"new", :name => "select" 
    
  end


  private
  def send_image
    if @dish.image.present?
      send_data @dish.image.data,
        type: @dish.image.content_type, disposition: "inline"
    end
  end
end
