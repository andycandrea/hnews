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

ActiveRecord::Schema.define(version: 20140724145446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: true do |t|
    t.string   "title",      null: false
    t.text     "content"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    null: false
  end

  create_table "comments", force: true do |t|
    t.text     "body",             null: false
    t.integer  "user_id",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "commentable_id",   null: false
    t.string   "commentable_type", null: false
  end

  create_table "users", force: true do |t|
    t.string   "name",                   null: false
    t.string   "email",                  null: false
    t.string   "password_digest",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token_digest"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_index "users", ["email", "name"], name: "index_users_on_email_and_name", unique: true, using: :btree
  add_index "users", ["remember_token_digest"], name: "index_users_on_remember_token_digest", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.boolean  "is_up"
    t.integer  "user_id",      null: false
    t.integer  "votable_id",   null: false
    t.string   "votable_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["user_id", "votable_id", "votable_type"], name: "index_votes_on_user_id_and_votable_id_and_votable_type", unique: true, using: :btree

end
