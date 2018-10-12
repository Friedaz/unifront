class HomeController < ApplicationController
  include CurrentCart
  before_action :set_cart
  before_action :search_params


def index
    @products = Product.all.paginate(page: params[:page], per_page: 6)
    @carts = Cart.all
    @line_item = LineItem.last

    if params[:search]
        @products = Product.where('name LIKE ?', "%#{params[:search]}%").paginate(page: params[:page], per_page: 6)
    else
        @products = Product.all.paginate(page: params[:page], per_page: 6)
    end
  end

  def new
    @receipients = @product.user[:email]
  end

    # GET /products/1
    # GET /products/1.json
    def show

    end

  private
    def search_params
      params.permit(:search, :product_name)
    end

end
