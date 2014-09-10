FactoryGirl.define do
  factory :error_response, class: ApiResource do
    status_code { rand(10) }
    status_message { Faker::Lorem.sentence }
  end
end