class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
  validates :nickname
  validates :birthday
  end

  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ } do
  validates :last_name
  validates :first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/ } do
  validates :last_name_kana
  validates :first_name_kana
  end

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates :password, presence: true, length: { minimum: 6 }, format: { with: VALID_PASSWORD_REGEX, message: 'は英数字混合で入力してください'}
  #validates :password, presence: true, length: { minimum: 6 }, format: { with: VALID_PASSWORD_REGEX, message: 'Include both letters and numbers'}

  has_many :items
  has_many :purchases

end
