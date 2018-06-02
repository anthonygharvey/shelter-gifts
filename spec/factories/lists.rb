require 'faker'
FactoryBot.define do
  factory :list do
    name { Faker::Company.buzzword }
    description { Faker::Company.catch_phrase }
    url { "https://www.amazon.com/gp/registry/wishlist/" }
  end
end
