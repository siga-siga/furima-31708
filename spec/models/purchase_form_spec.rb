require 'rails_helper'

RSpec.describe PurchaseForm, type: :model do
  before do
    @purchase_form = FactoryBot.build(:purchase_form)
  end

  describe '商品購入機能' do
    context '商品購入が成功する場合' do
      it 'postal_codeとprefecture_id、city、block、building、phone、tokenが存在すると購入できる' do
        expect(@purchase_form).to be_valid
      end

      it 'buildingが空でも購入できる' do
        @purchase_form.building = ''
        @purchase_form.valid?
        expect(@purchase_form).to be_valid
      end
    end

    context '商品購入が失敗する場合' do
      it 'postal_codeが空では購入できない' do
        @purchase_form.postal_code = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("郵便番号を入力してください")
        #expect(@purchase_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeにハイフンがない場合購入できない' do
        @purchase_form.postal_code = 1234567
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("郵便番号はハイフンを含めて入力してください")
        #expect(@purchase_form.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it 'prefecture_idが空では購入できない' do
        @purchase_form.prefecture_id = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("都道府県を入力してください")
        #expect(@purchase_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'prefecture_idが1だと購入できない' do
        @purchase_form.prefecture_id = 1
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("都道府県は1以外の値にしてください")
        #expect(@purchase_form.errors.full_messages).to include("Prefecture must be other than 1")
      end

      it 'cityが空では購入できない' do
        @purchase_form.city = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("市区町村を入力してください")
        #expect(@purchase_form.errors.full_messages).to include("City can't be blank")
      end

      it 'blockが空では購入できない' do
        @purchase_form.block = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("番地を入力してください")
        #expect(@purchase_form.errors.full_messages).to include("Block can't be blank")
      end

      it 'phoneが空では購入できない' do
        @purchase_form.phone = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("電話番号を入力してください")
        #expect(@purchase_form.errors.full_messages).to include("Phone can't be blank")
      end

      it 'phoneにハイフンが含まれる場合購入できない' do
        @purchase_form.phone = 123-4567-8910
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("電話番号はハイフンを含めないで入力してください")
        #expect(@purchase_form.errors.full_messages).to include("Phone is invalid")
      end

      it 'phoneが12桁以上の場合購入できない' do
        @purchase_form.phone = 123456789101
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("電話番号は10桁もしくは11桁で入力してください")
        #expect(@purchase_form.errors.full_messages).to include("Phone is invalid")
      end

      it 'item_idが空では購入できない' do
        @purchase_form.item_id = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Itemを入力してください")
        #expect(@purchase_form.errors.full_messages).to include("Item can't be blank")
      end

      it 'user_idが空では購入できない' do
        @purchase_form.user_id = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Userを入力してください")
        #expect(@purchase_form.errors.full_messages).to include("User can't be blank")
      end

      it 'tokenが空では購入できない' do
        @purchase_form.token = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("カード情報を入力してください")
        #expect(@purchase_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end