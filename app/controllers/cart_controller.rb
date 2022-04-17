class CartController < ApplicationController
  include AppHelpers::Cart
  include AppHelpers::Shipping

  before_action :set_item, :only => [:add_item, :remove_item]

  def show
    @items_in_cart = get_list_of_items_in_cart()
    @subtotal = calculate_cart_items_cost()
    @shipping_cost = calculate_cart_shipping()
    @total = @subtotal + @shipping_cost
  end

  def add_item
    @item = Item.find(params[:id])
    add_item_to_cart(params[:id])
    redirect_to @item
    flash[:notice] = "#{@item.name} was added to cart."
  end

  def remove_item
    @item = Item.find(params[:id])
    remove_item_from_cart(params[:id])
    redirect_to view_cart_path
    flash[:notice] = "#{@item.name} was removed from cart."
  end

  def empty_cart
    clear_cart()
    redirect_to view_cart_path
    flash[:notice] = "Cart is emptied."
  end

  def checkout
    @items_in_cart = get_list_of_items_in_cart()
    @subtotal = calculate_cart_items_cost()
    @shipping_cost = calculate_cart_shipping()
    @total = @subtotal + @shipping_cost
    @addresses = current_user.customer.addresses.by_recipient
    @order = Order.new
    # redirect_to order_path(@order)
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

end
