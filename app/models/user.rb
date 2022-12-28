class User < ApplicationRecord
  has_many :letters, through: :received_letters
  has_many :received_letters, dependent: :destroy
end
