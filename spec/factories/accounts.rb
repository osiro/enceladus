FactoryGirl.define do
  factory :account_response, class: ApiResource do
    id { "#{rand(99)}" }
    include_adult false
    iso_3166_1 "US"
    iso_639_1 "en"
    name { FFaker::Name.first_name }
    username { FFaker::Internet.email }
  end
end