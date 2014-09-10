require 'securerandom'

FactoryGirl.define do
  factory :production_company_collection_resource_response, class: ApiResource do
    id { rand(99) }
    logo_path { "/#{SecureRandom.hex}.png" }
    name { Faker::Company.name }
  end
end