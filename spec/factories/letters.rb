# == Schema Information
#
# Table name: letters
#
#  id              :bigint           not null, primary key
#  recommend_point :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  film_id         :integer          not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_letters_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :letter do
    film_id { 1 }
    recommend_point { "MyText" }
    user { nil }
  end
end
