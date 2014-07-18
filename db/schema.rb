# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140718133029) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: true do |t|
    t.integer  "counters"
    t.integer  "power"
    t.integer  "toughness"
    t.boolean  "covered",    default: true,  null: false
    t.boolean  "tapped",     default: false, null: false
    t.boolean  "flipped",    default: false, null: false
    t.integer  "game_id",                    null: false
    t.integer  "stamp_id",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",                   null: false
    t.integer  "player_id"
    t.integer  "slot_id",                    null: false
  end

  create_table "decks", force: true do |t|
    t.string   "name"
    t.text     "mainboard"
    t.text     "sideboard"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "player_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.string   "type",            default: "Player"
    t.integer  "game_id"
    t.integer  "user_id"
    t.string   "name"
    t.integer  "lives",           default: 20
    t.integer  "poison_counters", default: 0
    t.string   "settings"
    t.text     "mainboard"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deck_id",                            null: false
  end

  create_table "slots", force: true do |t|
    t.string   "name",       null: false
    t.integer  "position"
    t.integer  "player_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stamps", force: true do |t|
    t.string   "name"
    t.text     "names"
    t.text     "text"
    t.text     "originalText"
    t.text     "rulings"
    t.text     "printings"
    t.text     "legalities"
    t.text     "flavor"
    t.string   "manaCost"
    t.string   "cmc"
    t.string   "colors"
    t.string   "card_type"
    t.string   "types"
    t.string   "supertypes"
    t.string   "subtypes"
    t.string   "rarity"
    t.string   "loyalty"
    t.string   "power"
    t.string   "toughness"
    t.string   "layout"
    t.string   "artist"
    t.string   "edition"
    t.string   "number"
    t.string   "multiverseid"
    t.string   "imageName"
    t.string   "originalType"
    t.string   "variations"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",                                null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "cards", "games", name: "cards_game_id_fk"
  add_foreign_key "cards", "players", name: "cards_player_id_fk"
  add_foreign_key "cards", "stamps", name: "cards_stamp_id_fk"

  add_foreign_key "players", "users", name: "players_user_id_fk"

  add_foreign_key "slots", "players", name: "slots_player_id_fk"

end
