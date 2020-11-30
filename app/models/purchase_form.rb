class PurchaseForm < ApplicationRecord
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :block, :building, :phone, :item_id, :user_id, :token

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "はハイフンを含めて入力してください"}
    #validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: " is invalid. Include hyphen(-)"} #エラー文日本語化のためコメントアウト
    validates :prefecture_id, numericality: {other_than: 1}
    validates :city
    validates :block
    validates :phone, format: {with: /\A\d{10,11}\z/, message: "はハイフンを含めないで入力してください" }
    validates :phone, format: {with: /\A\d{10,11}\z/, message: "は10桁もしくは11桁で入力してください" }
    validates :item_id
    validates :user_id
    validates :token
  end

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, block: block, building: building, phone: phone)
  end
end


