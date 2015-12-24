FactoryGirl.define do
  factory :alternative_title_response, class: ApiResource do
    id { rand(10) }
    titles do
      [
        {
          iso_3166_1: FFaker::Lorem.characters(2).upcase,
          title: FFaker::Lorem.sentence
        }
      ]
    end
  end
end