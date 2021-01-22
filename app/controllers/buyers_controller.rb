class BuyersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!, onry: [:index, :create]

  def index
    @buyer_address = BuyerAddress.new
    redirect_to root_path if current_user.id == @item.user.id || !@item.buyer.nil?
  end

  def create
    @buyer_address = BuyerAddress.new(address_params)
    if @buyer_address.valid?
      pay_item
      @buyer_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def address_params
    params.require(:buyer_address).permit(:post_code,
                                          :prefecture_code_id, :city, :house_number, :building_name, :phone_number).merge(
                                            user_id: current_user.id, item_id: @item.id, token: params[:token]
                                          )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: address_params[:token],
      currency: 'jpy'
    )
  end
end
