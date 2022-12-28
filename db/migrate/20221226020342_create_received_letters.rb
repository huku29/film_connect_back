class CreateReceivedLetters < ActiveRecord::Migration[7.0]
  def change
    create_table :received_letters do |t|
      t.references :user, null: false, foreign_key: true
      t.references :letter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
