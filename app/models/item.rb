class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one :buyer
  has_one_attached :image

  belongs_to :category
  belongs_to :item_condition
  belongs_to :postage_type
  belongs_to :prefecture_code
  belongs_to :preparation_day

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :image, presence: true

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :item_condition_id
    validates :postage_type_id
    validates :preparation_day_id
    validates :prefecture_code_id
  end
end
