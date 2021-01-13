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

  validates :category_id, numericality: { other_than: 1 }

  validates :item_condition_id, numericality: { other_than: 1 }

  validates :postage_type_id, numericality: { other_than: 1 }

  validates :prefecture_code_id, numericality: { other_than: 0 }

  validates :preparation_day_id, numericality: { other_than: 1 }
end
