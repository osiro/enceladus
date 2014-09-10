require 'securerandom'

FactoryGirl.define do
  factory :guest_account_response, class: ApiResource do
    guest_session_id { SecureRandom.hex }
    success true
    expires_at { (Time.now + (60 * 60 * 24 * 10)).utc.to_s }
  end
end