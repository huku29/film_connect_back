class NotWatchFilmLetter < ApplicationRecord
  belongs_to :user
  belongs_to :letter

  validates :user_id, uniqueness: { scope: :letter_id }
end
