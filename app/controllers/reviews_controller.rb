class ReviewsController < ApplicationController
  def create
    @product = Product.find params[:product_id]
    # params usings symbols as keys, we need to pass in symbols too
    print params
    @review = Review.new params.require(:review).permit(:body, :rating)
    @review.product = @product

    if @review.save
      redirect_to product_path(@product)
    else
      render 'products/show'
    end
  end
end
