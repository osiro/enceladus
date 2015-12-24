FactoryGirl.define do
  factory :production_company_response, class: ApiResource do
    description { FFaker::Lorem.sentence }
    headquarters { FFaker::Address.street_address }
    homepage { FFaker::Internet.http_url }
    id { rand(1000) }
    logo_path { "/#{FFaker::Name.name}.png" }
    name { FFaker::Company.name }
    parent_company { FFaker::Company.name }
  end
end
