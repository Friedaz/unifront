class ProfilController < ApplicationController

def index
  @products = Product.all
  @stores = Store.all
  @users= User.includes(:products, :stores)
end
    # GET /products/1
    # GET /products/1.json
    def show
    end

end
