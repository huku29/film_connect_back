class Api::V1::NotWatchFilmLettersController < ApplicationController
  def create
  end
end


module Api
  module V1
    class NotWatchFilmLettersController < ApplicationController

      before_action :set_auth,  only: %i[info, index]
      before_action :set_current_user, only: %i[ info, index]
      include FirebaseAuthConcern

      def index
        not_watch_films = NotWatchFilmLetter.where(user: @current_user).all
        render json:{not_watch_films: not_watch_films}, status: :ok
      end
      
      def create
        @auth = authenticate_token_by_firebase
        uid = @auth[:data][:uid]
        @current_user = User.find_by(uid: uid)
        not_watch_film = register_not_watch_film_letter(@current_user,not_watch_film_letter_params)
        # binding.pry
        if not_watch_film.save
          render json: { data: not_watch_film }
        else
          render json: not_watch_film.errors.messages, status: :unprocessable_entity
        end
      end


      def rank
        not_watch_film_letter_movie_id = NotWatchFilmLetter.pluck(:letter_id)
        letters = Letter.where(id:not_watch_film_letter_movie_id )
        not_watch_film_letter_ranking = letters.group(:film_id).order('count(film_id) DESC').limit(5).pluck(:film_id)
        render json:  not_watch_film_letter_ranking, status: :ok
      end


      def info 
        @auth = authenticate_token_by_firebase
        uid = @auth[:data][:uid]
        @current_user = User.find_by(uid: uid)
        not_watch_film_letters = get_not_watch_film_letters_id(@current_user).pluck(:letter_id)
        render json: not_watch_film_letters, status: :ok
      end

      def not_watch_film_letters_detail
        not_watch_film_letters_detail = Letter.where(id: params[:letter_id]).all
        # binding.pry
        render json:{not_watch_film_letters_detail: not_watch_film_letters_detail }, status: :ok
      end




      private

      def set_auth
      end
      
      def set_current_user
        @auth = authenticate_token_by_firebase
        uid = @auth[:data][:uid]
        @current_user = User.find_by(uid: uid)
      end


      def register_not_watch_film_letter(current_user,not_watch_film_letter_params)
        not_watch_film_letter_params[:user] = current_user
        # binding.pry
        NotWatchFilmLetter.new(not_watch_film_letter_params)
      end

      def get_not_watch_film_letters_id(current_user)
        NotWatchFilmLetter.where(user_id:current_user)
        # binding.pry
      end


      def not_watch_film_letter_params
        params.require(:not_watch_film_letter).permit(:letter_id,:user_id)
      end

    end
  end
end
