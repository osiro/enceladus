FactoryGirl.define do
  factory :movies_production_company_response, class: ApiResource do
    id { rand(50) }
    name { FFaker::Lorem.word }
  end
end