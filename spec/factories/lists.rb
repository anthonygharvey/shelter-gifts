require 'faker'
FactoryBot.define do
  factory :list do
    name { Faker::Company.buzzword }
    description { Faker::Company.catch_phrase }
    url { Faker::Internet.url }
  end
end
