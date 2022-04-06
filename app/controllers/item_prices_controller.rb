class ItemPricesController < ApplicationController
  # before_action :set_item, :only => [:edit, :update]
  # before_action :check_login, :except => [:index]

  def new
    @item = Item.new
  end

  def create
    @item_price = ItemPrice.new(item_price_params)
    if @item_price.save
      flash[:notice] = "Successfully updated the price."
      redirect_to item_path(@item_price.item)
    else
      render action: 'new'
    end
  end

  private
  # def set_item_price
  #   @item_price = ItemPrice.find(params[:id])
  # end

  def item_price_params
    params.require(:item_price).permit(:item_id, :price)
  end

end
