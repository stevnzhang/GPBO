class OrdersController < ApplicationController
  include AppHelpers::Cart
  include AppHelpers::Shipping

  #before_action :set_order, only: [:index, :show]
  # before_action :check_login
  authorize_resource

  def index
    if current_user.role?(:customer)
      @all_orders = current_user.customer.orders.chronological
    else
      @pending_orders = Order.not_shipped.chronological
      @past_orders = Order.all.chronological - Order.not_shipped
    end
  end

  def show
    @order = Order.find(params[:id])
    @previous_orders = current_user.customer.orders.chronological.to_a - [@order]
    @order_items = OrderItem.alphabetical
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      # Add to cart?
      flash[:notice] = "Thank you for ordering from GPBO."
      redirect_to order_path(@order)
    else
      redirect_to :checkout
      # render action: 'new'
    end
  end

  private
  def order_params
    subtotal = calculate_cart_items_cost()
    shipping_cost = calculate_cart_shipping()
    params
    .require(:order)
    .permit(:customer_id, :address_id, :credit_card_number, :expiration_year, :expiration_month)
    .with_defaults(date: Date.current, products_total: subtotal, shipping: shipping_cost, payment_receipt: nil)
  end

end
