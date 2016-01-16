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

ActiveRecord::Schema.define(version: 20160115201418) do

  create_table "cars", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "car_class"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "cars", ["name"], name: "index_cars_on_name", unique: true

  create_table "terms", force: :cascade do |t|
    t.string   "person"
    t.integer  "car_id"
    t.integer  "price"
    t.date     "date_of_rent"
    t.date     "date_of_return"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "terms", ["car_id"], name: "index_terms_on_car_id"

end
