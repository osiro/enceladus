require 'securerandom'

FactoryGirl.define do
  factory :request_token_response, class: ApiResource do
    expires_at { (Time.now + (60 * 60 * 24 * 10)).utc.to_s }
    request_token { SecureRandom.hex }
    success true
  end
end
