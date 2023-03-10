# == Schema Information
#
# Table name: received_letters
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  letter_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_received_letters_on_letter_id  (letter_id)
#  index_received_letters_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (letter_id => letters.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe ReceivedLetter, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
