require 'rails_helper'

RSpec.describe BuyerAddress, type: :model do
  before do
    seller = FactoryBot.create(:user)
    buyer = FactoryBot.create(:user)
    item = FactoryBot.create(:item, user_id: seller.id)
    @address = FactoryBot.build(:buyer_address, user_id: buyer.id, item_id: item.id)
    sleep(1)
  end

  describe '商品の購入' do
    context '商品が購入できる場合' do
      it '郵便番号・都道府県・市区町村・番地・電話番号・tokenがあれば購入できる' do
        expect(@address).to be_valid
      end
      it '建物名が空でも購入できる' do
        @address.building_name = ''
        expect(@address).to be_valid
      end
    end
    context '商品が購入できない場合' do
      it '郵便番号がないと購入できない' do
        @address.post_code = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Post code can't be blank")
      end
      it 'prefecture_code_idが1の時は購入できない' do
        @address.prefecture_code_id = 1
        @address.valid?
        expect(@address.errors.full_messages).to include('Prefecture code must be other than 1')
      end
      it 'prefecture_code_idが空の時は購入できない' do
        @address.prefecture_code_id = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Prefecture code can't be blank")
      end
      it '市町村がないと購入できない' do
        @address.city = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("City can't be blank")
      end
      it '番地がないと購入できない' do
        @address.house_number = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("House number can't be blank")
      end
      it '電話番号がないと購入できない' do
        @address.phone_number = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Phone number can't be blank")
      end
      it '郵便番号にはハイフンがないと購入できない' do
        @address.post_code = '1111111'
        @address.valid?
        expect(@address.errors.full_messages).to include('Post code is invalid')
      end
      it '電話番号にハイフンがあると購入できない' do
        @address.phone_number = '090-1234-5678'
        @address.valid?
        expect(@address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号に全角数字があると購入できない' do
        @address.phone_number = '０９０１２３４５６７８'
        @address.valid?
        expect(@address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が英数字混合では購入できない' do
        @address.phone_number = '090-AbCd-5678'
        @address.valid?
        expect(@address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号は11桁以内でないと購入できない' do
        @address.phone_number = '090123456789'
        @address.valid?
        expect(@address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'tokenが空では購入できないこと' do
        @address.token = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idが空では購入できないこと' do
        @address.user_id = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空では購入できないこと' do
        @address.item_id = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
