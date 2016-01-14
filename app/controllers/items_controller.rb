class ItemsController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update, :destroy]

  def index
    # @items = Item.all.order('created_at DESC')

    # this action only display items if for the current user
    if user_signed_in?
      @items = Item.where(:user_id => current_user.id).order('created_at DESC')
    end
    
  end

  def show
  end

  #this is where controls the new view
  def new
    # @item = Item.new
    @item = current_user.items.build
  end

  #this is the action, this takes a param
  def create
    # @item = Item.new(item_params)
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private
    def item_params
      params.require(:item).permit(:title, :description)
    end

    def find_item
      @item = Item.find(params[:id])
    end
end
