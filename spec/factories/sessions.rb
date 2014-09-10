require 'securerandom'

FactoryGirl.define do
  factory :session_response, class: ApiResource do
    session_id { SecureRandom.hex }
    success true
  end
end
