FactoryGirl.define do
  factory :production_country_response, class: ApiResource do
    iso_3166_1 { Faker::Lorem.characters(2).upcase }
    name { Faker::Address.country }
  end
end