FactoryGirl.define do
  factory :production_country_response, class: ApiResource do
    iso_3166_1 { FFaker::Lorem.characters(2).upcase }
    name { FFaker::Address.country }
  end
end