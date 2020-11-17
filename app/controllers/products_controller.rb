class ProductsController < ApplicationController
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
end
