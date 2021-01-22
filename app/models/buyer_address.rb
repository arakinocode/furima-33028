class BuyerAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_code_id, :city, :house_number, :building_name, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :prefecture_code_id, numericality: { other_than: 1 }
    validates :city, format: { with: /\A[ぁ-んァ-ン一-龥々]/ }
    validates :house_number
    validates :phone_number, format: { with: /\A\d{11}\z/ }
  end

  def save
    buyer = Buyer.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, prefecture_code_id: prefecture_code_id, city: city,
                   house_number: house_number, building_name: building_name, phone_number: phone_number, buyer_id: buyer.id)
  end
end
