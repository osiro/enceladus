FactoryGirl.define do
  factory :credits_collection_response, class: ApiResource do
    id { "#{rand(10)}" }
    cast { [ FactoryGirl.build(:credits_response) ] }
  end
end