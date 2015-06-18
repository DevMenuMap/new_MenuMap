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

ActiveRecord::Schema.define(version: 20150618003916) do

  create_table "addrcompletes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "addrcompletes", ["name"], name: "index_addrcompletes_on_name", unique: true, using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "category_relationships", force: :cascade do |t|
    t.integer  "category_id",    limit: 4
    t.integer  "subcategory_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "category_relationships", ["category_id"], name: "index_category_relationships_on_category_id", using: :btree
  add_index "category_relationships", ["subcategory_id"], name: "index_category_relationships_on_subcategory_id", using: :btree

  create_table "notices", force: :cascade do |t|
    t.string   "question",   limit: 255
    t.string   "answer",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "email",      limit: 255
    t.text     "contents",   limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id", using: :btree

  create_table "rest_errs", force: :cascade do |t|
    t.integer  "restaurant_id", limit: 4
    t.boolean  "presence_err",  limit: 1,     default: false
    t.boolean  "menu_err",      limit: 1,     default: false
    t.boolean  "phnum_err",     limit: 1,     default: false
    t.boolean  "category_err",  limit: 1,     default: false
    t.text     "etc",           limit: 65535
    t.boolean  "active",        limit: 1,     default: true
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "rest_errs", ["restaurant_id"], name: "index_rest_errs_on_restaurant_id", using: :btree

  create_table "rest_infos", force: :cascade do |t|
    t.integer  "restaurant_id", limit: 4
    t.text     "owner_intro",   limit: 65535
    t.decimal  "naver_lat",                   precision: 11, scale: 8
    t.decimal  "naver_lng",                   precision: 11, scale: 8
    t.boolean  "active",        limit: 1,                              default: true
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
  end

  add_index "rest_infos", ["restaurant_id"], name: "index_rest_infos_on_restaurant_id", using: :btree

  create_table "rest_registers", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.string   "email",            limit: 255
    t.string   "name",             limit: 255
    t.integer  "category_id",      limit: 4
    t.integer  "subcategory_id",   limit: 4
    t.string   "addr",             limit: 255
    t.string   "phnum",            limit: 255
    t.boolean  "delivery",         limit: 1
    t.string   "open_at",          limit: 255
    t.text     "etc",              limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "img_file_name",    limit: 255
    t.string   "img_content_type", limit: 255
    t.integer  "img_file_size",    limit: 4
    t.datetime "img_updated_at"
  end

  add_index "rest_registers", ["category_id"], name: "index_rest_registers_on_category_id", using: :btree
  add_index "rest_registers", ["subcategory_id"], name: "index_rest_registers_on_subcategory_id", using: :btree
  add_index "rest_registers", ["user_id"], name: "index_rest_registers_on_user_id", using: :btree

  create_table "restaurants", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "category_id",    limit: 4
    t.integer  "subcategory_id", limit: 4
    t.string   "addr",           limit: 255
    t.string   "phnum",          limit: 255
    t.boolean  "delivery",       limit: 1,   default: false
    t.integer  "menu_on",        limit: 4,   default: 0
    t.string   "open_at",        limit: 255
    t.boolean  "active",         limit: 1,   default: true
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "restaurants", ["category_id"], name: "index_restaurants_on_category_id", using: :btree
  add_index "restaurants", ["subcategory_id"], name: "index_restaurants_on_subcategory_id", using: :btree

  create_table "subcategories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "category_relationships", "categories"
  add_foreign_key "category_relationships", "subcategories"
  add_foreign_key "rest_errs", "restaurants"
  add_foreign_key "rest_infos", "restaurants"
  add_foreign_key "rest_registers", "categories"
  add_foreign_key "rest_registers", "subcategories"
  add_foreign_key "rest_registers", "users"
  add_foreign_key "restaurants", "categories"
  add_foreign_key "restaurants", "subcategories"
end
