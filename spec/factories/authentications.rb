FactoryGirl.define do
  factory :authentication_response, class: ApiResource do
    request_token { rand.to_s.gsub(".", "") }
    success true
  end
end