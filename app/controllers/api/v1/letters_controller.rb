module Api
  module V1
    class LettersController < ApplicationController

      include FirebaseAuthConcern
      before_action :set_auth, only: %i[create]

  

      include CreateLetterConcern
      def create
        create_letter(@auth, letter_params)
      end




      private

      def set_auth
        @auth = authenticate_token_by_firebase
      end

      def letter_params
        params.fetch(:letter,{}).permit(:film_id,:recommend_point)
      end

    end
  end
end