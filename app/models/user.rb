class User < ApplicationRecord
  has_many :letters, through: :received_letters, dependent: :destroy
  has_many :letters, through: :not_watch_film_letters, dependent: :destroy

  has_many :received_letters
  has_many :not_watch_film_letters
end
