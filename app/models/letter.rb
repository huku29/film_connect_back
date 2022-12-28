class Letter < ApplicationRecord
  belongs_to :user
  has_many :received_letters, dependent: :destroy

  validates :recommend_point, presence: true, length: { minimum: 30 }
  validates :film_id, presence: true
end
