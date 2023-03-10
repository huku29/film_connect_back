# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  uid        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name) UNIQUE
#  index_users_on_uid   (uid) UNIQUE
#
class User < ApplicationRecord
  has_many :letters, through: :received_letters, dependent: :destroy
  has_many :letters, through: :not_watch_film_letters, dependent: :destroy

  has_many :received_letters
  has_many :not_watch_film_letters
end
