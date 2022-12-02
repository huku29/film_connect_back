class CreateLetters < ActiveRecord::Migration[7.0]
  def change
    create_table :letters do |t|
      t.integer :film_id, null: false
      t.text :recommend_point, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
