class ReceivedLetter < ApplicationRecord
  belongs_to :user
  belongs_to :letter
end
