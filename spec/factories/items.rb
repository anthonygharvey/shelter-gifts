require 'faker'
FactoryBot.define do
  factory :item do
    transient do
      amount_requested { Faker::Number.between(1, 25) }
    end

    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range = 0..100.00, as_string = false) }
    photo { Faker::Avatar.image("my-own-slug", "135x135", "jpg") }
    prime_status { Faker::Boolean.boolean(0.1) }
    comment { Faker::Food.describe }
    quantity { amount_requested }
    priority {["highest", "high", "medium", "low", "lowest", ""].sample}
    has_amount { [*0..amount_requested].sample }
    url { Faker::Internet.url }
  end
end
