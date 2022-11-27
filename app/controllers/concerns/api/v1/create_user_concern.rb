module Api
  module V1
    module CreateUserConcern
      extend ActiveSupport::Concern

      def create_user(auth, twitter_user_name)
        render json: auth, status: :unauthorized and return unless auth[:data]
        

        uid = auth[:data][:uid]
        # email = auth[:data][:decoded_token][:payload]["email"]
        render json: { message: 'すでに登録されています' } and return if User.find_by(uid: uid)

        user = User.new(name: "@#{twitter_user_name}", uid: uid)
        if user.save
          render json: { message: '登録が成功しました' }
        else
          render json: user.errors.messages, status: :unprocessable_entity
        end
      end
    end
  end
end