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

ActiveRecord::Schema.define(version: 20170317120501) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "apps", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_assets", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "app_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "data_assets", ["app_id"], name: "index_data_assets_on_app_id", using: :btree

  create_table "data_assets_metrics", id: false, force: :cascade do |t|
    t.integer "data_asset_id", null: false
    t.integer "metric_id",     null: false
  end

  add_index "data_assets_metrics", ["data_asset_id"], name: "index_data_assets_metrics_on_data_asset_id", using: :btree
  add_index "data_assets_metrics", ["metric_id"], name: "index_data_assets_metrics_on_metric_id", using: :btree

  create_table "dimensions", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.float    "expectation", default: 0.5
    t.integer  "weight",      default: 1
    t.integer  "app_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dimensions", ["app_id"], name: "index_dimensions_on_app_id", using: :btree

  create_table "metrics", force: :cascade do |t|
    t.string   "name"
    t.float    "weight",             default: 1.0
    t.integer  "dimension_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.text     "improvement_advice"
  end

  add_index "metrics", ["dimension_id"], name: "index_metrics_on_dimension_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "app_id"
    t.text     "content"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["app_id"], name: "index_notifications_on_app_id", using: :btree

  create_table "rollups", force: :cascade do |t|
    t.datetime "stamp"
    t.float    "avg",           default: 0.0
    t.float    "min",           default: 1.0
    t.float    "max",           default: 0.0
    t.string   "resolution"
    t.integer  "metric_id"
    t.integer  "dimension_id"
    t.integer  "app_id"
    t.float    "sum",           default: 0.0
    t.integer  "count",         default: 0
    t.integer  "data_asset_id"
  end

  add_index "rollups", ["app_id", "resolution", "stamp"], name: "index_rollups_on_app_id_and_resolution_and_stamp", using: :btree
  add_index "rollups", ["app_id"], name: "index_rollups_on_app_id", using: :btree
  add_index "rollups", ["data_asset_id", "resolution", "stamp"], name: "index_rollups_on_data_asset_id_and_resolution_and_stamp", using: :btree
  add_index "rollups", ["data_asset_id"], name: "index_rollups_on_data_asset_id", using: :btree
  add_index "rollups", ["dimension_id", "resolution", "stamp"], name: "index_rollups_on_dimension_id_and_resolution_and_stamp", using: :btree
  add_index "rollups", ["dimension_id"], name: "index_rollups_on_dimension_id", using: :btree
  add_index "rollups", ["metric_id", "resolution", "stamp"], name: "index_rollups_on_metric_id_and_resolution_and_stamp", using: :btree
  add_index "rollups", ["metric_id"], name: "index_rollups_on_metric_id", using: :btree
  add_index "rollups", ["stamp"], name: "index_rollups_on_stamp", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "values", force: :cascade do |t|
    t.datetime "stamp"
    t.float    "value"
    t.integer  "metric_id"
  end

  add_index "values", ["metric_id"], name: "index_values_on_metric_id", using: :btree
  add_index "values", ["stamp"], name: "index_values_on_stamp", using: :btree

  add_foreign_key "data_assets", "apps"
end
