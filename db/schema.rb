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

ActiveRecord::Schema.define(version: 20150710070628) do

  create_table "addr_conversions", force: :cascade do |t|
    t.integer  "address_id",   limit: 8
    t.string   "convert_to",   limit: 255
    t.string   "convert_from", limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "active",       limit: 1,   default: true
  end

  add_index "addr_conversions", ["address_id"], name: "index_addr_conversions_on_address_id", using: :btree
  add_index "addr_conversions", ["convert_from"], name: "index_addr_conversions_on_convert_from", using: :btree

  create_table "addr_rules", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "name",       limit: 255
    t.boolean  "active",     limit: 1,   default: true
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "addr_rules", ["user_id"], name: "index_addr_rules_on_user_id", using: :btree

  create_table "addrcompletes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "addrcompletes", ["name"], name: "index_addrcompletes_on_name", unique: true, using: :btree

  create_table "addresses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "admin_addrs", force: :cascade do |t|
    t.string   "gu",         limit: 255
    t.string   "dong",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

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

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "restaurant_id", limit: 4
    t.string   "contents",      limit: 255
    t.boolean  "active",        limit: 1,   default: true
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "comments", ["restaurant_id"], name: "index_comments_on_restaurant_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "coordinates", force: :cascade do |t|
    t.integer  "latlng_id",   limit: 8
    t.string   "latlng_type", limit: 255
    t.decimal  "lat",                     precision: 11, scale: 8
    t.decimal  "lng",                     precision: 11, scale: 8
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "coordinates", ["latlng_type", "latlng_id"], name: "index_coordinates_on_latlng_type_and_latlng_id", using: :btree

  create_table "legal_addrs", force: :cascade do |t|
    t.string   "gu",         limit: 255
    t.string   "dong",       limit: 255
    t.boolean  "mt",         limit: 1,   default: false
    t.string   "jibun",      limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "legal_admins", force: :cascade do |t|
    t.integer  "legal_addr_id", limit: 4
    t.integer  "admin_addr_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "legal_admins", ["admin_addr_id"], name: "index_legal_admins_on_admin_addr_id", using: :btree
  add_index "legal_admins", ["legal_addr_id"], name: "index_legal_admins_on_legal_addr_id", using: :btree

  create_table "menu_comments", force: :cascade do |t|
    t.integer  "menu_id",    limit: 4
    t.integer  "comment_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "menu_comments", ["comment_id"], name: "index_menu_comments_on_comment_id", using: :btree
  add_index "menu_comments", ["menu_id"], name: "index_menu_comments_on_menu_id", using: :btree

  create_table "menu_titles", force: :cascade do |t|
    t.integer  "restaurant_id", limit: 4
    t.string   "title_name",    limit: 255
    t.string   "title_info",    limit: 255
    t.boolean  "active",        limit: 1,   default: true
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "menu_titles", ["restaurant_id"], name: "index_menu_titles_on_restaurant_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.integer  "menu_title_id", limit: 4
    t.integer  "user_id",       limit: 4
    t.string   "name",          limit: 255
    t.string   "side_info",     limit: 255
    t.integer  "price",         limit: 4
    t.string   "info",          limit: 255
    t.boolean  "sitga",         limit: 1,   default: false
    t.boolean  "active",        limit: 1,   default: true
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "unidentified",  limit: 1,   default: false
    t.integer  "best",          limit: 4,   default: 0
  end

  add_index "menus", ["menu_title_id"], name: "index_menus_on_menu_title_id", using: :btree
  add_index "menus", ["user_id"], name: "index_menus_on_user_id", using: :btree

  create_table "my_maps", force: :cascade do |t|
    t.integer  "restaurant_id", limit: 4
    t.integer  "user_id",       limit: 4
    t.integer  "rating",        limit: 4
    t.string   "contents",      limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "my_maps", ["restaurant_id"], name: "index_my_maps_on_restaurant_id", using: :btree
  add_index "my_maps", ["user_id"], name: "index_my_maps_on_user_id", using: :btree

  create_table "notices", force: :cascade do |t|
    t.string   "question",   limit: 255
    t.string   "answer",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.integer  "imageable_id",     limit: 4
    t.string   "imageable_type",   limit: 255
    t.string   "name",             limit: 255
    t.boolean  "active",           limit: 1,   default: true
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "img_file_name",    limit: 255
    t.string   "img_content_type", limit: 255
    t.integer  "img_file_size",    limit: 4
    t.datetime "img_updated_at"
  end

  add_index "pictures", ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id", using: :btree

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
    t.integer  "user_id",       limit: 4
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
  add_index "rest_errs", ["user_id"], name: "index_rest_errs_on_user_id", using: :btree

  create_table "rest_infos", force: :cascade do |t|
    t.integer  "restaurant_id", limit: 4
    t.text     "owner_intro",   limit: 65535
    t.boolean  "active",        limit: 1,     default: true
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "rest_infos", ["restaurant_id"], name: "index_rest_infos_on_restaurant_id", using: :btree

  create_table "rest_registers", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.string   "email",          limit: 255
    t.string   "name",           limit: 255
    t.integer  "category_id",    limit: 4
    t.integer  "subcategory_id", limit: 4
    t.string   "addr",           limit: 255
    t.string   "phnum",          limit: 255
    t.boolean  "delivery",       limit: 1
    t.string   "open_at",        limit: 255
    t.text     "etc",            limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
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

  create_table "slangs", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "active",     limit: 1,   default: true
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "slangs", ["name"], name: "index_slangs_on_name", using: :btree

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
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "addr_conversions", "addresses"
  add_foreign_key "addr_rules", "users"
  add_foreign_key "category_relationships", "categories"
  add_foreign_key "category_relationships", "subcategories"
  add_foreign_key "comments", "restaurants"
  add_foreign_key "comments", "users"
  add_foreign_key "legal_admins", "admin_addrs"
  add_foreign_key "legal_admins", "legal_addrs"
  add_foreign_key "menu_comments", "comments"
  add_foreign_key "menu_comments", "menus"
  add_foreign_key "menu_titles", "restaurants"
  add_foreign_key "menus", "menu_titles"
  add_foreign_key "menus", "users"
  add_foreign_key "my_maps", "restaurants"
  add_foreign_key "my_maps", "users"
  add_foreign_key "rest_errs", "restaurants"
  add_foreign_key "rest_errs", "users"
  add_foreign_key "rest_infos", "restaurants"
  add_foreign_key "rest_registers", "categories"
  add_foreign_key "rest_registers", "subcategories"
  add_foreign_key "rest_registers", "users"
  add_foreign_key "restaurants", "categories"
  add_foreign_key "restaurants", "subcategories"
end
