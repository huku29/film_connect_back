module Api
  module V1
    class LettersController < ApplicationController

      include FirebaseAuthConcern
      before_action :set_auth,  only: %w[random create index random_by_english]
      before_action :set_current_user, only: %w[random create index random_by_english]

      def index
        letters = Letter.where(user_id: @current_user.id).all
        film_id_all = letters.pluck(:film_id)
        render json:{letter: letters, film_id_all: film_id_all }, status: :ok
      end

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

      def random_by_english 
        letter = random_letter(@current_user)
        if letter.present?
          sender_user_id = letter.user_id
          film_id = letter.film_id
          detail = GetFilmData.detail_film_by_english(film_id)
          user = User.find_by(id: sender_user_id)
          current_user_id = @current_user.id
          render json:{letter: letter, user: user, detail: detail ,current_user_id: current_user_id}, status: :ok
        else
          render json:{message:"受け取れるおすすめ映画がありません"}, status: :ok
        end
      end


      def create
        letter = create_letter(@current_user, letter_params)
        if letter.save
          render json: { data: letter }
        else
          render json: letter.errors.messages, status: :unprocessable_entity
        end
      end

      def rank
        created_letter_ranking =Letter.group(:film_id).order('count(film_id) DESC').limit(5).pluck(:film_id)
        render json:  created_letter_ranking, status: :ok
      end



      private

      def set_auth
        @auth = authenticate_token_by_firebase
        render json: @auth, status: :unauthorized and return unless @auth[:data]
      end

      def set_current_user
        uid = @auth[:data][:uid]
        @current_user = User.find_by(uid: uid)
        render json: { message: 'ユーザが存在しません' }, status: :bad_request and return if @current_user.blank?
      end


      def letter_params
        params.require(:letter).permit(:film_id,:recommend_point)
      end

      def random_letter(current_user)
        received_letter_id_list = current_user.received_letters.pluck(:letter_id)
        # 自分以外のユーザーが作成したレターの数を定義してる
        other_user_letters = Letter.where.not(user_id:  current_user.id)
        count = other_user_letters.where.not(id: received_letter_id_list).length
        # offsetは歯ぬきをよしなに処理してくれる。自分が作っていないレターの総数から自分の作っていないレターをランダムに選択して、一つ表示させる。
        other_user_letters.where.not(id: received_letter_id_list).offset(rand(count -1)).limit(1).first
      end

      def create_letter(current_user, letter_params)    
        letter_params[:user] = current_user
        letter = Letter.new(letter_params)
      end

    end
  end
end

