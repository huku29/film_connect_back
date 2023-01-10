module Api
  module V1
    class ReceivedLettersController < ApplicationController

      include FirebaseAuthConcern
      before_action :set_auth, only: %w[create index]
      before_action :set_current_user, only: %w[create index]



      def index
        received_letters = received_letters(@current_user)
        render json:{received_letters: received_letters }, status: :ok
      end

      def create
        letter = register_received_letter(@current_user,received_letter_params)
        if letter.save
          render json: { data: letter }
        else
          render json: letter.errors.messages, status: :unprocessable_entity
        end
      end


      def info
        received_letters = get_received_letters_data(params[:letter_id])
        render json:{received_letters: received_letters }, status: :ok
      end


      private

      def set_auth
        @auth = authenticate_token_by_firebase
        render json: @auth, status: :unauthorized and return unless @auth[:data]
      end
      
      def set_current_user
        @auth = authenticate_token_by_firebase
        uid = @auth[:data][:uid]
        @current_user = User.find_by(uid: uid)
      end

      
      
      def received_letters(current_user)
        current_user_id = current_user.id
        ReceivedLetter.where(user_id: current_user_id).all
      end
      

      def register_received_letter(current_user,received_letter_params )
        received_letter = Letter.find_by(id: received_letter_params[:letter_id])
        render json: { message: 'ユーザが存在しません' }, status: :bad_request and return if current_user.blank? 
        received_letter_params[:letter] = received_letter
        received_letter_params[:user] = current_user
        ReceivedLetter.new(received_letter_params)
      end

      def get_received_letters_data(received_letters_params)
        Letter.where(id: received_letters_params).all
      end

      def received_letter_params
        params.require(:received_letter).permit(:letter_id,:user_id)
      end

    end
  end
end

