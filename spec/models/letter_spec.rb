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
require 'rails_helper'

RSpec.describe Letter, type: :model do
  describe 'validation' do
    it 'is valid with all attributes' do
      letter = build(:letter)
      expect(letter).to be_valid
      expect(letter.errors).to be_empty
    end

    it 'is invalid without recommend_point' do
      letter_without_recommend_point = build(:letter, recommend_point: "")
      expect(letter_without_recommend_point).to be_invalid
      expect(letter_without_recommend_point.errors[:recommend_point]).to include("can't be blank")
    end

    it 'is invalid less than 30 length recommend_point' do
      short_recommend_point = build(:letter, recommend_point: ('a' * 29))
      expect(short_recommend_point).to be_invalid
      expect(short_recommend_point.errors[:recommend_point]).to eq ["is too short (minimum is 30 characters)"]
    end
  end

end
