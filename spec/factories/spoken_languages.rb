FactoryGirl.define do
  factory :spoken_language_response, class: ApiResource do
    iso_639_1 { Faker::Lorem.characters(2).downcase }
    name { Faker::Address.country }
  end
end