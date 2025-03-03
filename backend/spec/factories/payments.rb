FactoryBot.define do
  factory :payment do
    amount { Faker::Commerce.price(range: 10..500.0) }
    association :order
  end
end
