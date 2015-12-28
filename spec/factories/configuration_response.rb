FactoryGirl.define do
  factory :configuration_response, class: ApiResponse do
    images do
      {
        base_url: "http://image.tmdb.org/t/p/",
        secure_base_url: "https://image.tmdb.org/t/p/",
        backdrop_sizes: [ "w300", "w780", "w1280", "original" ],
        logo_sizes: [ "w45", "w92", "w154", "w185", "w300", "w500", "original" ],
        poster_sizes: [ "w92", "w154", "w185", "w342", "w500", "w780", "original" ],
        profile_sizes: [ "w45", "w185", "h632", "original" ],
        still_sizes: [ "w92", "w185", "w300", "original" ]
      }
    end

    change_keys ["adult","also_known_as","alternative_titles","biography","birthday","budget","cast","character_names",
        "crew","deathday","general","genres","homepage","images","imdb_id","name","original_title","overview","plot_keywords",
        "production_companies","production_countries","releases","revenue","runtime","spoken_languages","status","tagline",
        "title","trailers","translations"]
  end
end
