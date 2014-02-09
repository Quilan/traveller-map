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

ActiveRecord::Schema.define(version: 20140209190810) do

  create_table "base_systems", force: true do |t|
    t.integer  "system_id"
    t.integer  "base_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "base_systems", ["base_id"], name: "index_base_systems_on_base_id", using: :btree
  add_index "base_systems", ["system_id"], name: "index_base_systems_on_system_id", using: :btree

  create_table "bases", force: true do |t|
    t.string   "name"
    t.string   "symbol"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "broker_trade_goods", force: true do |t|
    t.integer  "broker_id"
    t.integer  "trade_good_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "broker_trade_goods", ["broker_id"], name: "index_broker_trade_goods_on_broker_id", using: :btree
  add_index "broker_trade_goods", ["trade_good_id"], name: "index_broker_trade_goods_on_trade_good_id", using: :btree

  create_table "brokers", force: true do |t|
    t.string   "name"
    t.integer  "system_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "brokers", ["system_id"], name: "index_brokers_on_system_id", using: :btree

  create_table "system_trade_codes", force: true do |t|
    t.integer  "system_id"
    t.integer  "trade_code_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "system_trade_codes", ["system_id"], name: "index_system_trade_codes_on_system_id", using: :btree
  add_index "system_trade_codes", ["trade_code_id"], name: "index_system_trade_codes_on_trade_code_id", using: :btree

  create_table "systems", force: true do |t|
    t.string   "name"
    t.integer  "col"
    t.integer  "row"
    t.integer  "size"
    t.integer  "atmosphere"
    t.string   "temperature"
    t.integer  "hydrographics"
    t.integer  "population"
    t.integer  "government"
    t.integer  "law"
    t.string   "starport"
    t.integer  "tech"
    t.string   "links"
    t.string   "bases"
    t.string   "trade_codes"
    t.string   "travel_code"
    t.string   "contraband"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subsector_id"
  end

  create_table "trade_code_goods", force: true do |t|
    t.integer  "trade_good_id"
    t.integer  "trade_code_id"
    t.integer  "dm"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trade_code_goods", ["trade_code_id"], name: "index_trade_code_goods_on_trade_code_id", using: :btree
  add_index "trade_code_goods", ["trade_good_id"], name: "index_trade_code_goods_on_trade_good_id", using: :btree

  create_table "trade_codes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trade_goods", force: true do |t|
    t.string   "name"
    t.text     "available"
    t.integer  "d66"
    t.integer  "ton_multiplier"
    t.integer  "base_price"
    t.text     "purchase_dm"
    t.text     "sale_dm"
    t.text     "examples"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
