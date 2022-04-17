class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :edit, :destroy, :toggle_active, :toggle_feature]
  before_action :check_login, only: [:show, :update, :edit, :destroy]
  authorize_resource

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @category = Category.new(category_params)
    if !@category.save
      @item.valid?
      render action: 'new'
    else
      @item.category_id = @category.id
      if @item.save
        flash[:notice] = "#{@item.name} was added to the system."
        redirect_to item_path(@item)
      # else
      #   render action: 'new'
      end
    end
  end

  def index
    @categories = Category.alphabetical
    if params[:category].present?
      category = Category.find(params[:category])
      @featured_items = Item.active.featured.for_category(category).alphabetical.paginate(page: params[:page]).per_page(15)
      @other_items = Item.active.for_category(category).alphabetical - Item.featured
    else
      @featured_items = Item.featured.alphabetical.paginate(page: params[:page]).per_page(15)
      @other_items = Item.active.alphabetical - Item.featured
    end
  end

  def show
    @prices = ItemPrice.for_item(@item)
    @similar_items = Item.for_category(@item.category)
  end

  def update
    if @item.update_attributes(item_params)
      flash[:notice] = "Successfully updated #{@item.name}."
      redirect_to @item
    else
      render action: 'edit'
    end
  end

  def edit
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.order_items != nil
      @item.destroy
      flash[:notice] = "Successfully removed this treatment."
      redirect_to @item
    end
  end

  def toggle_active
    if @item.active == true
      @item.update_attribute(:active, false)
      flash[:notice] = "#{@item.name} was made inactive"
    else
      @item.update_attribute(:active, true)
      flash[:notice] = "#{@item.name} was made active"
    end
    redirect_to @item
  end

  def toggle_feature
    if @item.is_featured
      @item.update_attribute(:is_featured, false)
      flash[:notice] = "#{@item.name} is no longer featured"
    else
      @item.update_attribute(:is_featured, true)
      flash[:notice] = "#{@item.name} is now featured"
    end
    redirect_to @item
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :association, :color, :inventory_level, :reorder_level, :weight, :is_featured, :active)
  end

  def category_params
    params.require(:item).permit(:name, :active)
  end

end
