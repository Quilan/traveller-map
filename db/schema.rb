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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131226163227) do

  create_table "systems", :force => true do |t|
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
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "subsector_id"
  end

end
