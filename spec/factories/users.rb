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
FactoryBot.define do
  factory :user do
    sequence(:name, 'user_1')
    sequence(:uid, 'uid_1')
  end
end
