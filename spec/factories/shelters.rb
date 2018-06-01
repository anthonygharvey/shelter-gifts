require 'faker'
FactoryBot.define do
  factory :shelter do
    name { Faker::Company.name }
    city { Faker::Address.city }
    state { Faker::Address.state }
    ein { Faker::Company.ein }
    shelter_type { Faker::Company.industry }
    description { Faker::Caompany.catch_phrase }
    website_url { Faker::Internet.url }    
  end
end
