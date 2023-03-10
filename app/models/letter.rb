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
class Letter < ApplicationRecord
  belongs_to :user
  has_many :received_letters, dependent: :destroy
  has_many :not_watch_film_letters, dependent: :destroy

  validates :recommend_point, presence: true, length: { minimum: 30 }
  validates :film_id, presence: true
end
