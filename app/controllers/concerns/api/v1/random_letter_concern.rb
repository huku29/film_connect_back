module Api
  module V1
    module RandomLetterConcern
      extend ActiveSupport::Concern

      def random_letter(current_user)
        received_letter_id_list = current_user.received_letters.pluck(:letter_id)
        # 自分以外のユーザーが作成したレターの数を定義してる
        other_user_letters = Letter.where.not(user_id:  current_user.id)
        count = other_user_letters.where.not(id: received_letter_id_list).length
        # offsetは歯ぬきをよしなに処理してくれる。自分が作っていないレターの総数から自分の作っていないレターをランダムに選択して、一つ表示させる。
        other_user_letters.where.not(id: received_letter_id_list).offset(rand(count -1)).limit(1).first
      end
    end
  end
end