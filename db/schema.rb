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

ActiveRecord::Schema.define(version: 20150104051036) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_ext_services", force: :cascade do |t|
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "areas", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "owner_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "visibility_level"
  end

  add_index "areas", ["owner_id"], name: "index_areas_on_owner_id", using: :btree
  add_index "areas", ["visibility_level"], name: "index_areas_on_visibility_level", using: :btree

  create_table "areas_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "area_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "areas_users", ["area_id"], name: "index_areas_users_on_area_id", using: :btree
  add_index "areas_users", ["user_id"], name: "index_areas_users_on_user_id", using: :btree

  create_table "broadcast_messages", force: :cascade do |t|
    t.string   "message"
    t.datetime "ends_at"
    t.datetime "starts_at"
    t.integer  "alert_type"
    t.string   "color"
    t.string   "font"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ext_services", force: :cascade do |t|
    t.integer  "social_net_id"
    t.integer  "consumer_id"
    t.string   "consumer_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "ext_services", ["consumer_type", "consumer_id"], name: "index_ext_services_on_consumer_type_and_consumer_id", using: :btree
  add_index "ext_services", ["social_net_id"], name: "index_ext_services_on_social_net_id", using: :btree

  create_table "focalpoints", force: :cascade do |t|
    t.integer  "area_id"
    t.string   "area_type"
    t.string   "name"
    t.string   "description"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "visibility_level"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "focalpoints", ["area_type", "area_id"], name: "index_focalpoints_on_area_type_and_area_id", using: :btree
  add_index "focalpoints", ["name"], name: "index_focalpoints_on_name", unique: true, using: :btree
  add_index "focalpoints", ["owner_type", "owner_id"], name: "index_focalpoints_on_owner_type_and_owner_id", using: :btree
  add_index "focalpoints", ["visibility_level"], name: "index_focalpoints_on_visibility_level", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "interests", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "visibility_level"
  end

  add_index "interests", ["name"], name: "index_interests_on_name", using: :btree
  add_index "interests", ["owner_type", "owner_id"], name: "index_interests_on_owner_type_and_owner_id", using: :btree
  add_index "interests", ["type"], name: "index_interests_on_type", using: :btree

  create_table "interests_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "interest_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "interests_users", ["interest_id"], name: "index_interests_users_on_interest_id", using: :btree
  add_index "interests_users", ["user_id"], name: "index_interests_users_on_user_id", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "of_id"
    t.string   "of_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "access_level"
  end

  add_index "memberships", ["access_level"], name: "index_memberships_on_access_level", using: :btree
  add_index "memberships", ["member_id"], name: "index_memberships_on_member_id", using: :btree
  add_index "memberships", ["of_type", "of_id"], name: "index_memberships_on_of_type_and_of_id", using: :btree

  create_table "namespaces", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "visibility_level"
  end

  add_index "namespaces", ["name"], name: "index_namespaces_on_name", unique: true, using: :btree
  add_index "namespaces", ["owner_type", "owner_id"], name: "index_namespaces_on_owner_type_and_owner_id", using: :btree
  add_index "namespaces", ["type"], name: "index_namespaces_on_type", using: :btree
  add_index "namespaces", ["visibility_level"], name: "index_namespaces_on_visibility_level", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "message"
    t.integer  "from_id"
    t.string   "from_type"
    t.integer  "to_id"
    t.string   "to_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notifications", ["from_type", "from_id"], name: "index_notifications_on_from_type_and_from_id", using: :btree
  add_index "notifications", ["to_type", "to_id"], name: "index_notifications_on_to_type_and_to_id", using: :btree
  add_index "notifications", ["type"], name: "index_notifications_on_type", using: :btree

  create_table "social_nets", force: :cascade do |t|
    t.string   "name"
    t.string   "api_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "enabled"
  end

  create_table "social_nets_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "social_net_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "username"
    t.boolean  "verified"
  end

  add_index "social_nets_users", ["social_net_id"], name: "index_social_nets_users_on_social_net_id", using: :btree
  add_index "social_nets_users", ["user_id"], name: "index_social_nets_users_on_user_id", using: :btree
  add_index "social_nets_users", ["verified"], name: "index_social_nets_users_on_verified", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.boolean  "admin",                  default: false, null: false
    t.boolean  "locked",                 default: false, null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
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
    t.string   "authentication_token"
    t.string   "provider"
    t.string   "extern_uid"
    t.string   "username"
    t.string   "name"
    t.integer  "visibility_level"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "areas_users", "areas"
  add_foreign_key "areas_users", "users"
  add_foreign_key "ext_services", "social_nets"
  add_foreign_key "identities", "users"
  add_foreign_key "interests_users", "interests"
  add_foreign_key "interests_users", "users"
  add_foreign_key "social_nets_users", "social_nets"
  add_foreign_key "social_nets_users", "users"
end
