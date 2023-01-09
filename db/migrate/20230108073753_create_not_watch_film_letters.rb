class CreateNotWatchFilmLetters < ActiveRecord::Migration[7.0]
  def change
    create_table :not_watch_film_letters do |t|
      t.references :user, null: false, foreign_key: true
      t.references :letter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
