class Order < ApplicationRecord
  belongs_to :user
  belongs_to :cart, optional: true
  has_many :line_items, dependent: :destroy
  belongs_to :user

  def add_line_items_from_cart(cart)
    cart.line_item.each do |item|
    item.cart_id = nil
    line_items << item
  end
end


attr_accessor :stripe_card_token

def save_with_payment
  if valid?
    customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
    self.stripe_customer_token = customer.id
    save!
  end
rescue Stripe::InvalidRequestError => e
  logger.error "Stripe error while creating customer: #{e.message}"
  errors.add :base, "There was a problem with your credit card."
  false
end

end
