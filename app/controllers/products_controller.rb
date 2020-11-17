class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: 'DESC')
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new params.require(:product).permit(:title, :description, :price)
    if @product.save
      flash[:notice] = 'Created new product!'
      redirect_to '/'
    else
      render :new
    end
  end

  def show
    @product = Product.find params[:id]
  end

  def destroy
    @product = Product.find params[:id]
    if @product.destroy
      flash[:notice] = 'Destroyed Product!'
      redirect_to products_path
    else
      flash[:notice] = 'Failed to destroy product...'
      redirect_to product_path(@product)
    end
  end
end
