module Api
  module V1
    module RandomLetterConcern
      extend ActiveSupport::Concern

      def random_letter(auth)
  
        render json: auth, status: :unauthorized and return unless auth[:data]
        uid = auth[:data][:uid]
        current_user = User.find_by(uid: uid)
        current_user_id = current_user.id
        count = Letter.where.not(user_id: current_user_id).length
        letter = Letter.where.not(user_id: current_user_id).offset(rand(count)).limit(1).first
        sender_user_id = letter.user_id
        film_id = letter.film_id
        detail = GetFilmData.detail_film(film_id)
        user = User.find_by(id: sender_user_id)
        render json:{letter: letter, user: user, detail: detail }, status: :ok
      end
    end
  end
end