require 'date'

FactoryGirl.define do
  factory :movie_collection_resource_response, class: ApiResource do
    adult false
    backdrop_path { "/#{FFaker::Name.name}.png" }
    id { rand(1000) }
    original_title { FFaker::Lorem.sentence }
    release_date { (Date.new - rand(10)).to_s }
    poster_path { "/#{FFaker::Name.name}.png" }
    popularity { rand * 10 }
    title { FFaker::Lorem.sentence }
    vote_average { rand * 10 }
    vote_count { rand(9999) }
  end
end