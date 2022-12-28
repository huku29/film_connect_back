module Api
  module V1
    class LettersController < ApplicationController

      include FirebaseAuthConcern
      before_action :set_auth,  only: %i[random create index]
      before_action :set_current_user, only: %i[random create index]

      def index
        letters = Letter.where(user_id: @current_user.id).all
        film_id_all = letters.pluck(:film_id)
        render json:{letter: letters, film_id_all: film_id_all }, status: :ok
      end


      include RandomLetterConcern
      def random 
        letter = random_letter(@current_user)
        if letter.present?
          sender_user_id = letter.user_id
          film_id = letter.film_id
          detail = GetFilmData.detail_film(film_id)
          user = User.find_by(id: sender_user_id)
          current_user_id = @current_user.id
          render json:{letter: letter, user: user, detail: detail ,current_user_id: current_user_id}, status: :ok
        else
          render json:{message:"受け取れるおすすめ映画がありません"}, status: :ok
        end

      end

      
  

      include CreateLetterConcern
      def create
        create_letter(@auth, letter_params)
      end




      private


      def set_auth
        @auth = authenticate_token_by_firebase
        render json: @auth, status: :unauthorized and return unless @auth[:data]
      end

      def set_current_user
        uid = @auth[:data][:uid]
        @current_user = User.find_by(uid: uid)
      end


      def letter_params
        params.require(:letter).permit(:film_id,:recommend_point)
      end

    end
  end
end

