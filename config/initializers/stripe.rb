Rails.configuration.stripe = {
  :publishable_key => ENV['pk_test_j79CwAThdaez7YmR7wIfU6px'],
  :secret_key      => ENV['sk_test_Svazov8ZZyjU6mkeettid8J1']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]