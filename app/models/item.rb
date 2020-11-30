class Item < ApplicationRecord
  belongs_to :user
  has_many_attached :images #複数枚投稿のため修正
  has_one :purchase

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :shipping_payer
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_day

  with_options presence: true do
  validates :name
  validates :content
  validates :category_id
  validates :status_id
  validates :shipping_payer_id
  validates :prefecture_id
  validates :delivery_day_id
  validates :images, length: { maximum: 5 } #複数枚投稿のため修正
  end

  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}

  validates :category_id, :status_id, :shipping_payer_id, :prefecture_id, :delivery_day_id, numericality: { other_than: 1 } 
end
