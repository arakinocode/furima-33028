class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @items = Item.all
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  # def purchase
  #   @item= Item.find(params[:id])
  #   @item.update(buyer_id: current_user.id)
  # end

  # def update
  #   if Item.update(item_params)
  #     redirect_to root_path
  #   else
  #     render :edit
  #   end
  # end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :category_id, :item_condition_id, :postage_type_id, :prefecture_code_id,
                                 :preparation_day_id, :image, :price).merge(user_id: current_user.id)
  end
end
