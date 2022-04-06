class SearchController < ApplicationController
  def search
    redirect_back(fallback_location: home_path) if params[:query].blank?
    @query = params[:query]
    @items = Item.search(@query)

    if current_user.role?(:admin)
      @customers = Customer.search(@query)
      @total_hits = @items.size + @customers.size
    elsif current_user.role?(:customer)
      @total_hits = @items.size
    end
  end
  
end
