FactoryGirl.define do
  factory :production_company_response, class: ApiResource do
    description { Faker::Lorem.sentence }
    headquarters { Faker::Address.street_address }
    homepage { Faker::Internet.url }
    id { rand(1000) }
    logo_path { "/#{Faker::Name.name}.png" }
    name { Faker::Company.name }
    parent_company { Faker::Company.name }
  end
end
