class ProductsController < InheritedResources::Base

include CurrentCart
  before_action :set_cart


  def index
    @products = Product.recent.order("created_at desc").page(params[:page]).per_page(3)
    @stores = Store.all
    @users = User.includes(:products, :stores)
  end

 def show
  @product = Product.find(params[:id])
  @reviews = Review.where(product_id: @product.id).order("created_at DESC")

    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end
 end

 def new
    @products= build_resource
    @store = build_resource
    @product.expired = 3.month.since Time.current
    @product.store_id = current_user[:store_id]
  end


  def create
  @product = Product.new(product_params)

  respond_to do |format|
    if @product.save

      if params[:image]
        #===== The magic is here ;)
        params[:image].each { |image|
          @product.images.create(image: image)
        }
      end

      format.html { redirect_to @product, notice: 'product was successfully created.' }
      format.json { render json: @product, status: :created, location: @product }
    else
      format.html { render action: "new" }
      format.json { render json: @product.errors, status: :unprocessable_entity }
    end
  end
end

  private

    def product_params
      params.require(:product).permit(:name, :description, :image, :price, :expired, :user_id, :store_id)
    end
end
