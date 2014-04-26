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

ActiveRecord::Schema.define(version: 20140424103426) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

end
