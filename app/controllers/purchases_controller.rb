class PurchasesController < ApplicationController
  before_action :set_purchase_form, only: [:index, :create]
  before_action :move_to_session_page, only: [:create]

  def index
    @purchase_form = PurchaseForm.new
    if current_user.id == @item.user_id || @item.purchase.present?
      redirect_to root_psth
    end
  end

  def create
    @purchase_form = @item.purchase.new(purchase_params)
    if @purchase_form.valid?
      @purchase_form.save
      redirect_to root_psth
    else
      render :index
    end
  end

  private
  def purchase_params
    params.require(:purchase).permit(:postal_code, :prefecture_id, :city, :block, :building, :phone).merge(user_id: current_user.id, item_id: @item.id)
  end

  def set_purchase_form
    @item = Item.find(params[:item_id])
  end

  def move_to_session_page
    unless user_signed_in?
      redirect_to session_path
    end
  end
end