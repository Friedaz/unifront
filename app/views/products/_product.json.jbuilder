json.extract! product, :id, :name, :description, :image, :price, :expired, :user_id, :store_id, :created_at, :updated_at
json.url product_url(product, format: :json)
