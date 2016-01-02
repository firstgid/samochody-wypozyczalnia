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

ActiveRecord::Schema.define(version: 20151225030532) do

  create_table "cars", force: :cascade do |t|
    t.string   "nazwa"
    t.string   "opis"
    t.string   "klasa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cars", ["nazwa"], name: "index_cars_on_nazwa", unique: true

  create_table "termins", force: :cascade do |t|
    t.string   "osoba"
    t.integer  "car_id"
    t.integer  "cena"
    t.date     "data_wyp"
    t.date     "data_odd"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "termins", ["car_id"], name: "index_termins_on_car_id"

end
