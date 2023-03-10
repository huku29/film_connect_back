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
  pending "add some examples to (or delete) #{__FILE__}"
end
