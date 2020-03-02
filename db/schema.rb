# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_02_003042) do

  create_table "lobbies", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "parite_games", force: :cascade do |t|
    t.string "title"
    t.integer "lobby_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lobby_id"], name: "index_parite_games_on_lobby_id"
  end

  create_table "players", force: :cascade do |t|
    t.boolean "ready"
    t.integer "user_id", null: false
    t.integer "parite_game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parite_game_id"], name: "index_players_on_parite_game_id"
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "tutorials", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "lobby_id"
    t.index ["lobby_id"], name: "index_users_on_lobby_id"
  end

  add_foreign_key "parite_games", "lobbies"
  add_foreign_key "players", "parite_games"
  add_foreign_key "players", "users"
  add_foreign_key "users", "lobbies"
end
