FactoryGirl.define do
  factory :account_response, class: ApiResource do
    id { "#{rand(99)}" }
    include_adult false
    iso_3166_1 "US"
    iso_639_1 "en"
    name { Faker::Name.first_name }
    username { Faker::Internet.email }
  end
end