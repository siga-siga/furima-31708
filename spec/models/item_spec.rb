require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品が成功する場合' do
      it 'nameとcontent、category_id、status_id、shipping_payer_id、prefecture_id、delivery_day_id、price、imagesが存在すると出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品が失敗する場合' do
      it 'nameが空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
        #expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'contentが空では出品できない' do
        @item.content = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
        #expect(@item.errors.full_messages).to include("Content can't be blank")
      end

      it 'category_idが空だと出品できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
        #expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it 'category_idが1だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーは1以外の値にしてください")
        #expect(@item.errors.full_messages).to include("Category must be other than 1")
      end

      it 'status_idが空では出品できない' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
        #expect(@item.errors.full_messages).to include("Status can't be blank")
      end

      it 'status_idが1では出品できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態は1以外の値にしてください")
        #expect(@item.errors.full_messages).to include("Status must be other than 1")
      end

      it 'shipping_payer_idが空では出品できない' do
        @item.shipping_payer_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
        #expect(@item.errors.full_messages).to include("Shipping payer can't be blank")
      end

      it 'shipping_payer_idが1では出品できない' do
        @item.shipping_payer_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担は1以外の値にしてください")
        #expect(@item.errors.full_messages).to include("Shipping payer must be other than 1")
      end

      it 'prefecture_idが空では出品できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
        #expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'prefecture_idが1では出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域は1以外の値にしてください")
        #expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end

      it 'delivery_day_idが空では出品できない' do
        @item.delivery_day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
        #expect(@item.errors.full_messages).to include("Delivery day can't be blank")
      end

      it 'delivery_day_idが1では出品できない' do
        @item.delivery_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数は1以外の値にしてください")
        #expect(@item.errors.full_messages).to include("Delivery day must be other than 1")
      end

      it 'priceが空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
        #expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが、¥300未満でない場合出品できない' do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は300以上の値にしてください")
        #expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end

      it 'priceが、¥1,000,000以上である場合出品できない' do
        @item.price = 10000001
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は9999999以下の値にしてください")
        #expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end

      it 'priceが半角数字でない場合出品できない' do
        @item.price = 'aaaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は数値で入力してください")
        #expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it 'imagesがなければ出品できない' do
        @item.images = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
        #expect(@item.errors.full_messages).to include("Images can't be blank")
      end
    end
  end
end
