class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]

  def index
    @purchase_form = PurchaseForm.new
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_params)
    if @purchase_form.valid?
      pay_item
      @purchase_form.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def purchase_params
    params.require(:purchase_form).permit(:postal_code, :prefecture_id, :city, :block, :building, :phone).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    if current_user.id == @item.user_id || @item.purchase.present?
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price,                   # 商品の値段
      card: purchase_params[:token],         # カードトークン
      currency: 'jpy'                        # 通貨の種類（日本円）
    )
  end
end