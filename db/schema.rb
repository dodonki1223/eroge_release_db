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

ActiveRecord::Schema.define(version: 2020_03_13_010516) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name", null: false
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_brands_on_name", unique: true
  end

  create_table "game_casts", force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "voice_actor_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id", "voice_actor_id"], name: "index_game_casts_on_game_id_and_voice_actor_id", unique: true
    t.index ["game_id"], name: "index_game_casts_on_game_id"
    t.index ["voice_actor_id"], name: "index_game_casts_on_voice_actor_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "title", null: false
    t.integer "brand_id", null: false
    t.date "date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brand_id"], name: "index_games_on_brand_id"
    t.index ["date"], name: "index_games_on_date"
    t.index ["title"], name: "index_games_on_title", unique: true
  end

  create_table "voice_actors", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_voice_actors_on_name", unique: true
  end

  add_foreign_key "game_casts", "games"
  add_foreign_key "game_casts", "voice_actors"
  add_foreign_key "games", "brands"
end
