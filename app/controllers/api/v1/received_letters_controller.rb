module Api
  module V1
    class ReceivedLettersController < ApplicationController

      include FirebaseAuthConcern
      before_action :set_auth, only: %i[create index]


      def index
        received_letters(@auth)
      end

      def create
        register_received_letter(@auth,received_letter_params)
      end

      def info
        get_received_letters_data(params[:letter_id])
      end


      
      private

      def register_received_letter(auth,received_letter_params )
        render json: auth, status: :unauthorized and return unless auth[:data]
        uid = auth[:data][:uid]
        current_user = User.find_by(uid: uid)
        received_letter = Letter.find_by(id: received_letter_params[:letter_id])
        render json: { message: 'ユーザが存在しません' }, status: :bad_request and return if current_user.blank? 
        received_letter_params[:letter] = received_letter
        received_letter_params[:user] = current_user
        letter = ReceivedLetter.new(received_letter_params)
        if letter.save
          render json: { data: letter }
        else
          render json: letter.errors.messages, status: :unprocessable_entity
        end
      end

      
      def received_letters(auth)
        render json: auth, status: :unauthorized and return unless auth[:data]
        uid = auth[:data][:uid]
        current_user = User.find_by(uid: uid)
        current_user_id = current_user.id
        received_letters = ReceivedLetter.where(user_id: current_user_id).all
        render json:{received_letters: received_letters }, status: :ok
      end


      def get_received_letters_data(received_letters_params)
        received_letters = Letter.where(id: received_letters_params).all
        render json:{received_letters: received_letters }, status: :ok
      end


      def set_auth
        @auth = authenticate_token_by_firebase
      end


      def received_letter_params
        params.require(:received_letter).permit(:letter_id,:receiver_id)
      end


    end
  end
end

