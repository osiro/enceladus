FactoryGirl.define do
  factory :credits_response, class: ApiResource do
    cast_id { rand(10) }
    character { Faker::Lorem.word }
    credit_id { "#{rand(999999)}" }
    id { rand(1000) }
    name { Faker::Name.name }
    order { rand(10) }
    profile_path { "/#{rand(99999)}.png" }
  end
end