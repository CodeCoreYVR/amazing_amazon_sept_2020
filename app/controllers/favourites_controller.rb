class FavouritesController < ApplicationController

    def index
        @favourites = current_user.favourited_products.order('favourites.created_at DESC')
    end

    def create
        product = Product.find params[:product_id]
        favourite = Favourite.new user: current_user, product: product
        if !can?(:favourite, product)
            flash[:alert] = "You can't favourite your own product"
        elsif favourite.save
            flash[:success] = "Product Favourited!"
        else
            flash[:warning] = favourite.errors.full_messages.join(', ')
        end
        redirect_to product
    end
    def destroy
        favourite = Favourite.find params[:id]
        if can? :destroy, favourite
            favourite.destroy
            flash[:warning] = "Unfavourited Product"
        else
            flash[:alert] = "Could not unfavourite product"
        end
        redirect_to favourite.product
    end
end
