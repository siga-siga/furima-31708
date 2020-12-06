class ItemsTag
  include ActiveModel::Model
  attr_accessor :item_id, :tag_id, :word, :name, :content, :category_id, :status_id, :shipping_payer_id, :prefecture_id, :delivery_day_id, :price, :images, :user_id

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

  def save
    item = Item.create(name: name, content: content, category_id: category_id, images: images, status_id: status_id, shipping_payer_id: shipping_payer_id, prefecture_id: prefecture_id, delivery_day_id: delivery_day_id, price: price, user_id: user_id)
    tag = Tag.where(word: word).first_or_initialize
    tag.save

    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
  end

  def update
    item = Item.find_by(id: item_id) 
    item.update(name: name, content: content, category_id: category_id, images: images, status_id: status_id, shipping_payer_id: shipping_payer_id, prefecture_id: prefecture_id, delivery_day_id: delivery_day_id, price: price, user_id: user_id, id: item_id)
    tag = Tag.where(word: word).first_or_create
    item.tags.clear
    item.tags << tag
  end
end 
