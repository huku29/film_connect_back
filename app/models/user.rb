class User < ApplicationRecord
  has_many :letters, dependent: :destroy
end
