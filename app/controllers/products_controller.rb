class ProductsController < ApplicationController
  before_action :authorize, except: [:index, :show]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @order_item = current_order.order_items.new
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Product created!"
      redirect_to '/'
    else
      flash[:alert] = @product.errors.full_messages
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "Product updated!"
      redirect_to '/'
    else
      flash[:alert] = @product.errors.full_messages
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = "Product deleted."
    redirect_to '/'
  end

private
  def product_params
    params.require(:product).permit(:name, :description, :price, :image)
  end
end
