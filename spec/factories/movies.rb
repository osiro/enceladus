require 'date'

FactoryGirl.define do
  factory :movie_response, class: ApiResource do
    adult false
    backdrop_path { "/#{FFaker::Name.name}.png" }
    belongs_to_collection nil
    budget { rand(99999999) }
    genres { [ build(:genre_response) ] }
    homepage { FFaker::Internet.http_url }
    id { rand(9999) }
    imdb_id { "tt#{rand(9999999)}" }
    original_title { FFaker::Lorem.sentence }
    overview { FFaker::Lorem.sentence }
    popularity { rand * 10 }
    poster_path { "/#{FFaker::Name.name}.png" }
    production_companies { [ build(:movies_production_company_response) ] }
    production_countries { [ build(:production_country_response) ] }
    release_date { (Date.new - rand(10)).to_s }
    revenue { rand(9999999) }
    runtime { rand(999) }
    spoken_languages { [ build(:spoken_language_response) ] }
    status "Released"
    tagline { FFaker::Lorem.sentence }
    title { FFaker::Lorem.sentence }
    vote_average { rand * 10 }
    vote_count { rand(9999) }
    releases { { countries: [ build(:certification_response) ] } }
    trailers { { youtube: [ build(:youtube_trailer_response) ] } }
  end
end