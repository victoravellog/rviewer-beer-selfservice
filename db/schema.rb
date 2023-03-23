# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_03_23_181834) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dispenser_usages", force: :cascade do |t|
    t.bigint "dispenser_id", null: false
    t.datetime "open_time", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "close_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dispenser_id"], name: "index_dispenser_usages_on_dispenser_id"
  end

  create_table "dispensers", force: :cascade do |t|
    t.decimal "flow_volume", precision: 4, scale: 4
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "dispenser_usages", "dispensers"
end
