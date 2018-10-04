class OrdersController < InheritedResources::Base
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :ensure_cart_isnt_empty, only: :new
  before_action :get_mailbox



  def index
    @cart = Cart.last
    @line_item = LineItem.last
    @conversations = current_user.mailbox.conversations
  end


def new
    @order = build_resource
    @order.payment_time = DateTime.now.to_date
    @line_item = LineItem.last
    @receipients = @line_item.product.user.email
    @order.user_id = @line_item.product.user.email
  end

 def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)
    respond_to do |format|
      if @order.save
        session[:cart_id] = nil
        format.html { redirect_to root_path, notice: 'Thank you for your order.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end


require "stripe"
Stripe.api_key = "sk_test_Svazov8ZZyjU6mkeettid8J1"
     # Amount in cents
  @amount = @cart.total_price.to_i * 100

  customer = Stripe::Customer.create(
    :email => params[:stripeEmail],
    :source  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
  )

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to new_charge_path


  receipient = User.find(params[:user_id])
  receipt = current_user.send_message(receipient, params[:body], params[:subject])
  redirect_to conversation_path(receipt.conversation)
end



  private

    def order_params
      params.require(:order).permit(:user_id, :cart_id, :total_price, :payment_time)
    end

  # private

  #   def order_params
  #     params.require(:order).permit(:user_id, :cart_id, :total_price, :payment_time)
  #   end

  private
    def ensure_cart_isnt_empty
      if @cart.line_item.empty?
        redirect_to root_path, notice: 'Your cart is empty'
    end
  end

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end

end

