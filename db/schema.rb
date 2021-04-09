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

ActiveRecord::Schema.define(version: 0) do

  create_table "areas", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
  end

  create_table "audiences", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
  end

  create_table "audiences_events", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.integer "audience_id", null: false, unsigned: true
    t.integer "event_id", null: false, unsigned: true
    t.index ["audience_id"], name: "fk_audiences_events_audience_id"
    t.index ["event_id"], name: "fk_audiences_events_event_id"
  end

  create_table "event_types", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
  end

  create_table "events", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.integer "event_type_id", unsigned: true
    t.string "name"
    t.text "description"
    t.datetime "when"
    t.text "where"
    t.string "url"
    t.text "map_url"
  end

  create_table "users", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "email"
    t.string "contact_email"
    t.text "description"
    t.string "telephone"
    t.datetime "updated_at"
  end

  add_foreign_key "audiences_events", "audiences", name: "fk_audiences_events_audience_id"
  add_foreign_key "audiences_events", "events", name: "fk_audiences_events_event_id"
end
