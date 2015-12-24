FactoryGirl.define do
  factory :genre_response, class: ApiResource do
    id { rand(50) }
    name { FFaker::Lorem.word }
  end
end