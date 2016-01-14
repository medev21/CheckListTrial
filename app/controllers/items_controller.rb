class ItemsController < ApplicationController

  def index
    @items = Item.all.order('created_at DESC')
  end

  #this is where controls the new view
  def new
    @item = Item.new
  end

  #this is the action, this takes a param
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
    def item_params
      params.require(:item).permit(:title, :description)
    end
end
