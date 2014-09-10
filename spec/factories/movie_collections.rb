FactoryGirl.define do
  factory :movie_collection_response, class: ApiResource do
    results { [ FactoryGirl.build(:movie_collection_resource_response) ] }
    page 1
    total_pages 1
    total_results { results.size }
  end
end