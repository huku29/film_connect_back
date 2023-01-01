module Api
  module V1
    class UsersController < ApplicationController
      include FirebaseAuthConcern
      before_action :set_auth, only: %i[create update]

      include CreateUserConcern
      def create
        create_user(@auth,params[:twitterUserName])
      end

      def info
        get_user_infos(params[:user_id])
      end


      private

      def set_auth
        @auth = authenticate_token_by_firebase
      end

      def get_user_infos(user_id)
        user_info = User.where(id: user_id).all
        render json: user_info, status: :ok
      end

    end
  end
end