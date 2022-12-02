class Letter < ApplicationRecord
  belongs_to :user

  validates :recommend_point, presence: true, length: { minimum: 30 }
  validates :film_id, presence: true
end
