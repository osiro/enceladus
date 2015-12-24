require 'date'

FactoryGirl.define do
  factory :certification_response, class: ApiResource do
    iso_3166_1 { FFaker::Lorem.characters(2).upcase }
    certification "R"
    release_date { (Date.new - rand(10)).to_s }
  end
end