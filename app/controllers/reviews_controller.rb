class ReviewsController < InheritedResources::Base
include CurrentCart
before_action :set_cart
before_action :set_review, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!
before_action :set_product

def create
  @review = Review.new(review_params)
  @review.user_id = current_user.id
  @review.product_id = @product.id

    if @review.save
      redirect_to root_path
    else
      render 'new'
    end
end

  private

    def set_review
      @review = Review.find(params[:id])
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end

