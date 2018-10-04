class Cart < ApplicationRecord
  has_many :line_item, dependent: :destroy

  def add_product(product)
    current_item = line_item.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_item.build(product_id: product.id)
    end
    current_item
  end

  def total_price
    line_item.to_a.sum { |item| item.total_price }
  end
end
