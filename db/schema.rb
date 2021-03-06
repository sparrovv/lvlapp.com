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

ActiveRecord::Schema.define(version: 20131114205346) do

  create_table "audio_videos", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "transcript"
    t.string   "url"
    t.decimal  "duration",    precision: 16, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.integer  "level_id"
    t.string   "status"
    t.integer  "views_count",                          default: 0
    t.boolean  "featured"
    t.string   "slug"
  end

  add_index "audio_videos", ["category_id"], name: "index_audio_videos_on_category_id", using: :btree
  add_index "audio_videos", ["featured"], name: "index_audio_videos_on_featured", using: :btree
  add_index "audio_videos", ["level_id"], name: "index_audio_videos_on_level_id", using: :btree
  add_index "audio_videos", ["slug"], name: "index_audio_videos_on_slug", unique: true, using: :btree
  add_index "audio_videos", ["status"], name: "index_audio_videos_on_status", using: :btree
  add_index "audio_videos", ["views_count"], name: "index_audio_videos_on_views_count", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "position",   default: 0
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree
  add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true, using: :btree

  create_table "game_data", force: true do |t|
    t.integer  "user_id"
    t.integer  "audio_video_id"
    t.integer  "blanks"
    t.integer  "guessed"
    t.integer  "skipped"
    t.integer  "mistakes"
    t.integer  "time"
    t.string   "level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_points"
    t.text     "summary"
  end

  add_index "game_data", ["total_points"], name: "index_game_data_on_total_points", using: :btree
  add_index "game_data", ["user_id", "audio_video_id"], name: "index_game_data_on_user_id_and_audio_video_id", using: :btree

  create_table "levels", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phrases", force: true do |t|
    t.string   "name"
    t.integer  "audio_video_id"
    t.text     "definition"
    t.text     "examples"
    t.string   "translation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "related"
    t.integer  "interval"
    t.float    "easiness_factor"
    t.date     "repetition_date"
    t.string   "sentence"
  end

  add_index "phrases", ["user_id"], name: "index_phrases_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.string   "native_language"
  end

  add_index "users", ["admin"], name: "index_users_on_admin", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
