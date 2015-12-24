FactoryGirl.define do
  factory :spoken_language_response, class: ApiResource do
    iso_639_1 { FFaker::Lorem.characters(2).downcase }
    name { FFaker::Address.country }
  end
end