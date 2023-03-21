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
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it 'is valid with all attributes' do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end
  end
end
