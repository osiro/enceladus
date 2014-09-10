FactoryGirl.define do
  factory :youtube_trailer_response, class: ApiResource do
    name { Faker::Lorem.sentence }
    size "HD"
    source { Faker::Lorem.characters(10) }
    type "Trailer"
  end
end
