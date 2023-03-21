# == Schema Information
#
# Table name: not_watch_film_letters
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  letter_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_not_watch_film_letters_on_letter_id  (letter_id)
#  index_not_watch_film_letters_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (letter_id => letters.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :not_watch_film_letter do
    association :user
    association :letter
  end
end
