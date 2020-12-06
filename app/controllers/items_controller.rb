class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    #@item = Item.new
    @item = ItemsTag.new
  end

  def create
    #@item = Item.new(item_params)
    @item = ItemsTag.new(item_params)
    if @item.valid?
      @item.save
      @items = Item.all.order(updated_at: :desc).limit(1)
      redirect_to item_path(@items.ids)
    else
      render :new
    end
  end

  def show
  end

  def edit
    @item_tag = ItemsTag.new
    unless current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def update
    @item_tag = ItemsTag.new(tag_params)
    if @item_tag.valid?
      @item_tag.update
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @item.user_id
      if @item.destroy
        redirect_to root_path
      else
        render :show
      end
    end
  end

  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['word LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  private
  def item_params
    params.require(:items_tag).permit(:name, :content, :category_id, :status_id, :shipping_payer_id, :prefecture_id, :delivery_day_id, :price, :word, images: []).merge(user_id: current_user.id)
  end

  def tag_params
    params.require(:item).permit(:name, :content, :category_id, :status_id, :shipping_payer_id, :prefecture_id, :delivery_day_id, :price, :word, images: []).merge(user_id: current_user.id,item_id: params[:id])
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    if @item.purchase.present?
      redirect_to root_path
    end
  end
end
