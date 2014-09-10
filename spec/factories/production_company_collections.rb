FactoryGirl.define do
  factory :production_company_collection_response, class: ApiResource do
    results { [ FactoryGirl.build(:production_company_collection_resource_response) ] }
    page 1
    total_pages 1
    total_results { results.size }
  end
end