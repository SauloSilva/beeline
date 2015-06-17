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

ActiveRecord::Schema.define(version: 20150616214234) do

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
  end

  add_index "cities", ["name"], name: "index_cities_on_name"

  create_table "routes", id: false, force: :cascade do |t|
    t.integer "to_id",    null: false
    t.integer "from_id",  null: false
    t.integer "distance", null: false
  end

  add_index "routes", ["from_id"], name: "index_routes_on_from_id"
  add_index "routes", ["to_id", "from_id"], name: "index_routes_on_to_id_and_from_id"
  add_index "routes", ["to_id"], name: "index_routes_on_to_id"

end
