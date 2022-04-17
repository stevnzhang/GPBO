class ItemPricesController < ApplicationController
  # before_action :set_item_price, :only => [:edit, :update]
  before_action :check_login

  def new
    @item = Item.find(params[:item_id])
    @item_price = ItemPrice.new
  end

  def create
    # @item = Item.find(params[:item_id])
    @item_price = ItemPrice.new(item_price_params)
    # @item_price.start_date = Date.current
    if @item_price.save
      flash[:notice] = "Successfully updated the price."
      redirect_to item_path(@item_price.item)
    else
      @item = Item.find(params[:item_price][:item_id])
      render action: 'new', locals: { item: @item }
      # render action: 'new'
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
