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

  create_table "activities", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "activity_type_id", unsigned: true
    t.integer "audience_id", unsigned: true
    t.boolean "global"
  end

  create_table "activities_areas", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.integer "activity_id", null: false, unsigned: true
    t.integer "area_id", null: false, unsigned: true
    t.column "role", "enum('organizer','interest')"
  end

  create_table "activity_types", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "description"
  end

  create_table "areas", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "payoff"
    t.text "description"
    t.text "notice"
    t.integer "in_charge", unsigned: true
  end

  create_table "areas_contacts", id: false, charset: "utf8mb4", force: :cascade do |t|
    t.integer "area_id", null: false, unsigned: true
    t.integer "contact_id", null: false, unsigned: true
  end

  create_table "areas_editions", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.integer "area_id", null: false, unsigned: true
    t.integer "edition_id", null: false, unsigned: true
    t.column "role", "enum('organizer','interest')"
  end

  create_table "audiences", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "description"
  end

  create_table "contacts", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.integer "user_id", unsigned: true
    t.string "name"
    t.text "description"
    t.string "email"
    t.string "web_page"
  end

  create_table "editions", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.integer "activity_id", unsigned: true
    t.string "name"
    t.text "description"
    t.integer "academic_year", limit: 2, unsigned: true
    t.integer "audience_id", unsigned: true
    t.integer "seats"
  end

  create_table "events", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.integer "edition_id", unsigned: true
    t.string "name"
    t.text "description"
    t.integer "audience_id", unsigned: true
    t.string "where"
    t.datetime "start_date"
    t.integer "duration"
    t.integer "seats"
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

end
