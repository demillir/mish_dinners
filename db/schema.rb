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

ActiveRecord::Schema.define(version: 20130827034713) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: true do |t|
    t.integer  "day_id"
    t.integer  "recipient_id"
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "css_class"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "appointments", ["day_id"], name: "index_appointments_on_day_id", using: :btree
  add_index "appointments", ["recipient_id"], name: "index_appointments_on_recipient_id", using: :btree

  create_table "days", force: true do |t|
    t.integer  "unit_id"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "days", ["unit_id"], name: "index_days_on_unit_id", using: :btree

  create_table "divisions", force: true do |t|
    t.string   "abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipients", force: true do |t|
    t.integer  "unit_id"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recipients", ["unit_id"], name: "index_recipients_on_unit_id", using: :btree

  create_table "units", force: true do |t|
    t.integer  "division_id"
    t.string   "abbr"
    t.string   "coordinator_email"
    t.string   "meal_time"
    t.text     "volunteer_pitch"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "units", ["division_id"], name: "index_units_on_division_id", using: :btree

end
