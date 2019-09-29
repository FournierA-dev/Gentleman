# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_29_210834) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "match_teams", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_match_teams_on_match_id"
    t.index ["team_id"], name: "index_match_teams_on_team_id"
  end

  create_table "matches", force: :cascade do |t|
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.string "tel_number"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_players_on_email", unique: true
    t.index ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true
  end

  create_table "pools", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scores", force: :cascade do |t|
    t.integer "score"
    t.bigint "match_id"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_scores_on_match_id"
    t.index ["team_id"], name: "index_scores_on_team_id"
  end

  create_table "team_players", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_team_players_on_player_id"
    t.index ["team_id"], name: "index_team_players_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.integer "total_score"
    t.bigint "pool_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pool_id"], name: "index_teams_on_pool_id"
  end

  add_foreign_key "match_teams", "matches"
  add_foreign_key "match_teams", "teams"
  add_foreign_key "scores", "matches"
  add_foreign_key "scores", "teams"
  add_foreign_key "team_players", "players"
  add_foreign_key "team_players", "teams"
  add_foreign_key "teams", "pools"
end
