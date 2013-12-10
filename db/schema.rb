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

ActiveRecord::Schema.define(version: 20131210231258) do

  # These are extensions that must be enabled in order to support this database
  # enable_extension "plpgsql"

  create_table "business_users", force: true do |t|
    t.string  "email"
    t.string  "name"
    t.string  "password"
    t.string  "title"
    t.integer "business_id"
    t.string  "password_digest"
  end

  add_index "business_users", ["business_id"], name: "index_business_users_on_business_id", using: :btree

  create_table "businesses", force: true do |t|
    t.string   "name"
    t.string   "company_type",   null: false
    t.integer  "founded_year",   null: false
    t.string   "status",         null: false
    t.string   "location",       null: false
    t.integer  "size",           null: false
    t.string   "stock_exchange"
    t.string   "ticker"
    t.text     "specialties",    null: false
    t.text     "culture"
    t.string   "domain",         null: false
    t.string   "url",            null: false
    t.string   "twitter"
    t.string   "facebook"
    t.string   "linkedin",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "businesses", ["name"], name: "index_businesses_on_name", unique: true, using: :btree

  create_table "keys", force: true do |t|
    t.string   "api",        null: false
    t.string   "tag",        null: false
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "keys", ["key"], name: "index_keys_on_key", unique: true, using: :btree

  create_table "posts", force: true do |t|
    t.integer  "business_id"
    t.string   "position",        null: false
    t.text     "summary",         null: false
    t.text     "desired_skills"
    t.text     "expected_skills"
    t.date     "start_at"
    t.datetime "expire_at",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["business_id"], name: "index_posts_on_business_id", using: :btree

  create_table "posts_profiles", id: false, force: true do |t|
    t.integer "profile_id", null: false
    t.integer "post_id",    null: false
  end

  create_table "profiles", force: true do |t|
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "password"
  end

  add_index "profiles", ["email"], name: "index_profiles_on_email", unique: true, using: :btree

  create_table "questions", force: true do |t|
    t.integer  "post_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["description"], name: "index_questions_on_description", unique: true, using: :btree
  add_index "questions", ["post_id"], name: "index_questions_on_post_id", using: :btree

  create_table "questions_videos", id: false, force: true do |t|
    t.integer "question_id", null: false
    t.integer "video_id",    null: false
  end

  create_table "skillgroups", force: true do |t|
    t.integer  "skillable_id",   null: false
    t.string   "skillable_type", null: false
    t.integer  "skill_id"
    t.integer  "proficiency",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skillgroups", ["skill_id"], name: "index_skillgroups_on_skill_id", using: :btree

  create_table "skillgroups_sources", id: false, force: true do |t|
    t.integer "skillgroup_id", null: false
    t.integer "source_id",     null: false
  end

  create_table "skills", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skills", ["name"], name: "index_skills_on_name", unique: true, using: :btree

  create_table "sources", force: true do |t|
    t.string   "source_type", null: false
    t.string   "intent",      null: false
    t.string   "origin",      null: false
    t.date     "started_at",  null: false
    t.date     "ended_at",    null: false
    t.text     "summary"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: true do |t|
    t.integer  "profile_id"
    t.string   "pandastream_id", null: false
    t.string   "url",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["pandastream_id"], name: "index_videos_on_pandastream_id", unique: true, using: :btree
  add_index "videos", ["profile_id"], name: "index_videos_on_profile_id", using: :btree
  add_index "videos", ["url"], name: "index_videos_on_url", unique: true, using: :btree

end
