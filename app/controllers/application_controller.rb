class ApplicationController < ActionController::Base
  include AppHelpers::Cart
  protect_from_forgery with: :exception

  # PATS!
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You are not authorized to perform this action."
    redirect_to home_path
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    flash[:error] = "We apologize, but this information could not be found."
    redirect_to home_path
  end

  private
  # Handling authentication, PATS!
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  def logged_in?
    current_user
  end
  helper_method :logged_in?
  
  def check_login
    redirect_to login_path, alert: "You need to log in to view this page." if current_user.nil?
  end

  def num_unique_items_in_cart
    get_list_of_items_in_cart().size
  end
  helper_method :num_unique_items_in_cart

end
