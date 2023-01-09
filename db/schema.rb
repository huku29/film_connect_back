# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_01_08_073753) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "letters", force: :cascade do |t|
    t.integer "film_id", null: false
    t.text "recommend_point", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_letters_on_user_id"
  end

  create_table "not_watch_film_letters", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "letter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["letter_id"], name: "index_not_watch_film_letters_on_letter_id"
    t.index ["user_id"], name: "index_not_watch_film_letters_on_user_id"
  end

  create_table "received_letters", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "letter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["letter_id"], name: "index_received_letters_on_letter_id"
    t.index ["user_id"], name: "index_received_letters_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "letters", "users"
  add_foreign_key "not_watch_film_letters", "letters"
  add_foreign_key "not_watch_film_letters", "users"
  add_foreign_key "received_letters", "letters"
  add_foreign_key "received_letters", "users"
end
