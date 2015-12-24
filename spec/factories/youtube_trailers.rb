FactoryGirl.define do
  factory :youtube_trailer_response, class: ApiResource do
    name { FFaker::Lorem.sentence }
    size "HD"
    source { FFaker::Lorem.characters(10) }
    type "Trailer"
  end
end
