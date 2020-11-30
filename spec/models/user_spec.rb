require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザー登録が成功する場合' do
      it 'nicknameとemail、password、password_confirmation、last_name、first_name、last_name_kana、first_name_kana、birthdayが存在すると登録できる' do
        expect(@user).to be_valid
      end
    end

    context 'ユーザー登録が失敗する場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
        #expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
        #expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'emailに＠が含まれない場合は登録できない' do
        @user.email = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
        #expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
        #expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
        #expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが半角英数混合でない場合は登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは英数字混合で入力してください")
        #expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
      end

      it 'passwordが半角数字のみの場合登録できない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは英数字混合で入力してください")
        #expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
      end

      it 'passwordが半角英字のみの場合登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは英数字混合で入力してください")
        #expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
      end

      it 'passwordが5文字以下であれば登録できない' do
        @user.password = 'bbbbb'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
        #expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
        #expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordとpassword_confirmationが不一致の場合登録できない' do
        @user.password = 'aaaaa1'
        @user.password_confirmation = 'aaaaa2'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
        #expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'ユーザーの本名は苗字が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください")
        #expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'ユーザーの本名は名前が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
        #expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'ユーザー本名の苗字は、全角（漢字・ひらがな・カタカナ）で入力されていない場合は登録できない' do
        @user.last_name = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字は不正な値です")
        #expect(@user.errors.full_messages).to include("Last name is invalid")
      end

      it 'ユーザー本名の名前は、全角（漢字・ひらがな・カタカナ）で入力されていない場合は登録できない' do
        @user.first_name = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は不正な値です")
        #expect(@user.errors.full_messages).to include("First name is invalid")
      end


      it 'ユーザー本名の苗字は、フリガナが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字（カナ）を入力してください")
        #expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'ユーザー本名の名前は、フリガナが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カナ）を入力してください")
        #expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'ユーザー本名の苗字は、フリガナが全角（カタカナ）で入力されていない場合は登録できない' do
        @user.last_name_kana = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字（カナ）は不正な値です")
        #expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end

      it 'ユーザー本名の名前は、フリガナが全角（カタカナ）で入力されていない場合は登録できない' do
        @user.first_name_kana = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カナ）は不正な値です")
        #expect(@user.errors.full_messages).to include("First name kana is invalid")
      end

      it 'birthが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お誕生日を入力してください")
        #expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
