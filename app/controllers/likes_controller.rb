class LikesController < ApplicationController
    before_action :authenticate_user!

    def create
        # When we create a like, we are providing a Review Id for the like to belong to
        review = Review.find params[:review_id]
        like = Like.new user: current_user, review: review
        if !can?(:like, review)
            flash[:alert] = "You can't like your own review"
        elsif like.save
            flash[:success] = "Review Liked!"
        else
            flash[:warning] = like.errors.full_messages.join(', ')
        end
        
        redirect_to review.product
    end

    def destroy
        # When we destroy a like, we provide the like Id directly to destory
        like = Like.find params[:id]
        # Defined in ability.rb
        if can? :destroy, like
            like.destroy
            flash[:warning] = "Unliked Review"
            redirect_to like.review.product
        else
            flash[:alert] = "Could not unlike review"
            redirect_to like.review.product
        end
    end
end
