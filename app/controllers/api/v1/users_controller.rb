module Api
  module V1
    class UsersController < ApplicationController
      include FirebaseAuthConcern
      before_action :set_auth, only: %w[create]
      before_action :create_user, only: %w[create]


      def create
        user = create_user(@auth,params[:twitterUserName])
        if user.save
          render json: { message: '登録が成功しました' }
        else
          render json: user.errors.messages, status: :unprocessable_entity
        end
      end

      def info
        user_info = get_user_infos(params[:user_id])
        render json: user_info, status: :ok
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

      def create_user(auth, twitter_user_name)
        uid = auth[:data][:uid]
        render json: { message: 'すでに登録されています' } and return if User.find_by(uid: uid)
        user = User.new(name: twitter_user_name, uid: uid)
      end

      def get_user_infos(user_id)
        User.where(id: user_id).all
      end

    end
  end
end