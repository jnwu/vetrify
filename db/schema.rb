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

ActiveRecord::Schema.define(version: 20140116052514) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apis", force: true do |t|
    t.string   "provider"
    t.string   "tag"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apis", ["key"], name: "index_apis_on_key", unique: true, using: :btree

  create_table "applicants", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "applicants", ["email"], name: "index_applicants_on_email", unique: true, using: :btree

  create_table "businesses", force: true do |t|
    t.string   "name"
    t.string   "business_type"
    t.integer  "founded_year"
    t.string   "status"
    t.string   "location"
    t.integer  "size"
    t.string   "stock_exchange"
    t.string   "ticker"
    t.text     "specialties"
    t.text     "culture"
    t.string   "domain"
    t.string   "url"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "linkedin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "businesses", ["name"], name: "index_businesses_on_name", unique: true, using: :btree

  create_table "positions", force: true do |t|
    t.integer  "applicant_id"
    t.integer  "business_id"
    t.string   "name"
    t.text     "summary"
    t.date     "started_at"
    t.date     "ended_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "positions", ["applicant_id"], name: "index_positions_on_applicant_id", using: :btree
  add_index "positions", ["business_id"], name: "index_positions_on_business_id", using: :btree

  create_table "repos", force: true do |t|
    t.integer  "applicant_id"
    t.string   "name"
    t.string   "language"
    t.date     "started_at"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  add_index "repos", ["applicant_id"], name: "index_repos_on_applicant_id", using: :btree

  create_table "tokens", force: true do |t|
    t.integer  "applicant_id"
    t.string   "provider"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tokens", ["applicant_id"], name: "index_tokens_on_applicant_id", using: :btree
  add_index "tokens", ["key"], name: "index_tokens_on_key", unique: true, using: :btree

end
