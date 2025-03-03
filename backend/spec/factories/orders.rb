FactoryBot.define do
  factory :order do
    ordered_at { Faker::Date.between(from: '2023-01-01', to: '2023-12-31') }
    item_type { Faker::Commerce.product_name }
    price_per_item { Faker::Commerce.price(range: 10..100.0) }
    quantity { Faker::Number.between(from: 1, to: 10) }
    shipping_cost { Faker::Commerce.price(range: 5..20.0) }
    tax_rate { 0.05 } # 5% tax rate
  end
end
