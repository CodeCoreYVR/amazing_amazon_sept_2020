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
end
