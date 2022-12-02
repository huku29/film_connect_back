module Api
  module V1
    module CreateLetterConcern
      extend ActiveSupport::Concern

      def create_letter(auth, letter_params)
        render json: auth, status: :unauthorized and return unless auth[:data]

        uid = auth[:data][:uid]
        user = User.find_by(uid: uid)
        render json: { message: 'ユーザが存在しません' }, status: :bad_request and return if user.blank?        

        letter_params[:user] = user
        letter = Letter.new(letter_params)
        if letter.save
          render json: { data: letter }
        else
          render json: letter.errors.messages, status: :unprocessable_entity
        end
      end
    end
  end
end