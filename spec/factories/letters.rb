FactoryBot.define do
  factory :letter do
    film_id { 1 }
    recommend_point { "MyText" }
    user { nil }
  end
end
