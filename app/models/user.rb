class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  validates :nickname, presence: true
  validates :password, presence: true, format: { with: VALID_PASSWORD_REGEX, message: 'は6文字以上、半角英数字それぞれ１文字以上含む必要があります' }
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: '全角文字を使用してください' } do
    validates :first_name
    validates :last_name
  end
  with_options presence: true, format: { with: /\A[ア-ン゛゜ァ-ォャ-ョー「」、]+\z/, message: '全角カタカナのみで入力して下さい' } do
    validates :first_name_kana
    validates :last_name_kana
  end
  validates :birth_day, presence: true

  has_many :items
  has_many :buyers
end
