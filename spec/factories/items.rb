require 'faker'
FactoryBot.define do
  factory :item do
    transient do
      amount_requested { Faker::Number.between(from: 1, to: 25) }
    end

    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: range = 0..100.00, as_string: as_string = false) }
    photo { Faker::Avatar.image(slug: "my-own-slug", size: "135x135", format: "jpg") }
    prime_status { Faker::Boolean.boolean(true_ratio: 0.1) }
    comment { Faker::Food.describe }
    quantity { amount_requested }
    priority {["highest", "high", "medium", "low", "lowest", ""].sample}
    has_amount { [*0..amount_requested].sample }
    url { "https://amazon.com/" }
    button_text { "Add to cart" }
    button_url { "https://www.amazon.com/" }
  end
end
