class CustomersController < ApplicationController
  before_action :set_customer, :only => [:show, :edit, :update]
  before_action :check_login, :only => [:show, :update, :edit]
  authorize_resource

  def index
    @active_customers = Customer.active.alphabetical
    @inactive_customers = Customer.inactive.alphabetical
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    @user = User.new(user_params)
    @user.role = "customer"
    if !@user.save
      @customer.valid?
      render action: 'new'
    else
      @customer.user_id = @user.id
      if @customer.save
        flash[:notice] = "#{@customer.proper_name} was added to the system."
        redirect_to customer_path(@customer) 
      else
        render action: 'new'
      end      
    end
  end

  def show
    @previous_orders = @customer.orders.chronological.to_a
    @addresses = @customer.addresses.to_a
  end

  def edit
  end

  def update
    respond_to do |format|
      if @customer.update_attributes(customer_params)
        format.html { redirect_to(@customer, :notice => "Successfully updated #{@customer.proper_name}.") }
        format.json { respond_with_bip(@customer) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@customer) }
      end
    end
  end

  private
  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :phone, :active, :username, :password, :password_confirmation)
  end

  def user_params      
    params.require(:customer).permit(:active, :username, :password, :password_confirmation)
  end

end
