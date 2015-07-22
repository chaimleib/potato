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

ActiveRecord::Schema.define(version: 20150722000836) do

  create_table "code_freezes", force: :cascade do |t|
    t.string   "version",    limit: 100
    t.string   "date",       limit: 26
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "code_freezes", ["version"], name: "index_code_freezes_on_version", using: :btree

  create_table "due_dates", force: :cascade do |t|
    t.string   "branch_name", limit: 255
    t.string   "due",         limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "due_ref_id",  limit: 4
  end

  add_index "due_dates", ["branch_name"], name: "index_due_dates_on_branch_name", unique: true, using: :btree

  create_table "resource_updates", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "updated"
    t.text     "source_uri", limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "resource_updates", ["name"], name: "index_resource_updates_on_name", using: :btree
  add_index "resource_updates", ["user_id"], name: "index_resource_updates_on_user_id", using: :btree

  create_table "user_permissions", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.boolean  "is_admin"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "user_permissions", ["user_id"], name: "index_user_permissions_on_user_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "fname",           limit: 255
    t.string   "lname",           limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "resource_updates", "users"
  add_foreign_key "user_permissions", "users"
end
