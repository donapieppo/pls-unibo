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

ActiveRecord::Schema.define(version: 2021_04_27_080855) do

  create_table "action_text_rich_texts", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.text "body", size: :long
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.string "type", limit: 50
    t.string "name"
    t.text "description"
    t.integer "academic_year", limit: 2, unsigned: true
    t.string "place"
    t.datetime "start_date"
    t.datetime "deadline"
    t.integer "seats", limit: 2, unsigned: true
    t.integer "parent_id", unsigned: true
    t.integer "audience_id", unsigned: true
    t.boolean "global"
    t.integer "duration", limit: 2, unsigned: true
    t.boolean "sofia"
    t.boolean "pcto"
  end

  create_table "activities_areas", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.integer "activity_id", null: false, unsigned: true
    t.integer "area_id", null: false, unsigned: true
  end

  create_table "activities_contacts", id: false, charset: "utf8mb4", force: :cascade do |t|
    t.integer "activity_id", unsigned: true
    t.integer "contact_id", unsigned: true
    t.index ["activity_id"], name: "fk_act_cont_activity_id"
    t.index ["contact_id"], name: "fk_act_cont_contact_id"
  end

  create_table "activities_resources", id: false, charset: "utf8mb4", force: :cascade do |t|
    t.integer "activity_id", unsigned: true
    t.integer "resource_id", unsigned: true
    t.index ["activity_id"], name: "fk_act_activity_id"
    t.index ["resource_id"], name: "fk_act_res_id"
  end

  create_table "activities_speakers", id: false, charset: "utf8mb4", force: :cascade do |t|
    t.integer "activity_id", unsigned: true
    t.integer "contact_id", unsigned: true
    t.index ["activity_id"], name: "fk_act_spk_activity_id"
    t.index ["contact_id"], name: "fk_act_spk_contact_id"
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
    t.integer "head_id", unsigned: true
    t.index ["head_id"], name: "fk_area_head"
  end

  create_table "areas_contacts", id: false, charset: "utf8mb4", force: :cascade do |t|
    t.integer "area_id", null: false, unsigned: true
    t.integer "contact_id", null: false, unsigned: true
  end

  create_table "areas_interests", id: false, charset: "utf8mb4", force: :cascade do |t|
    t.integer "area_id", unsigned: true
    t.integer "activity_id", unsigned: true
    t.index ["activity_id"], name: "fk_area_int_activity_id"
    t.index ["area_id"], name: "fk_area_int_area_id"
  end

  create_table "areas_organizations", id: false, charset: "utf8mb4", force: :cascade do |t|
    t.integer "area_id", null: false, unsigned: true
    t.integer "organization_id", null: false, unsigned: true
    t.index ["area_id"], name: "fk_area_org_area_id"
    t.index ["organization_id"], name: "fk_area_org_organization_id"
  end

  create_table "areas_resource_containers", id: false, charset: "utf8mb4", force: :cascade do |t|
    t.integer "area_id", unsigned: true
    t.integer "resource_container_id", unsigned: true
    t.index ["area_id"], name: "fk_ar_area_id"
    t.index ["resource_container_id"], name: "fk_ar_resource_id"
  end

  create_table "audiences", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "description"
  end

  create_table "bookings", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.integer "activity_id", unsigned: true
    t.integer "user_id", unsigned: true
    t.datetime "created_at"
    t.boolean "confirmed"
    t.index ["activity_id"], name: "fk_book_activity"
    t.index ["user_id"], name: "fk_book_user"
  end

  create_table "contacts", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.integer "user_id", unsigned: true
    t.string "name"
    t.text "description"
    t.string "email"
    t.string "web_page"
  end

  create_table "organizations", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "url"
  end

  create_table "resource_containers", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "global"
    t.timestamp "created_at", default: -> { "current_timestamp()" }, null: false
  end

  create_table "resource_containers_resources", id: false, charset: "utf8mb4", force: :cascade do |t|
    t.integer "resource_id", unsigned: true
    t.integer "resource_container_id", unsigned: true
    t.index ["resource_container_id"], name: "fk_res_c_id"
    t.index ["resource_id"], name: "fk_res_id"
  end

  create_table "resources", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.text "credits"
    t.timestamp "created_at", default: -> { "current_timestamp()" }, null: false
  end

  create_table "users", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.boolean "staff"
    t.string "name"
    t.string "surname"
    t.string "email"
    t.string "contact_email"
    t.text "description"
    t.string "telephone"
    t.datetime "last_login"
    t.datetime "updated_at"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities_contacts", "activities", name: "fk_act_cont_activity_id"
  add_foreign_key "activities_contacts", "contacts", name: "fk_act_cont_contact_id"
  add_foreign_key "activities_resources", "activities", name: "fk_act_activity_id"
  add_foreign_key "activities_resources", "resources", name: "fk_act_res_id"
  add_foreign_key "activities_speakers", "activities", name: "fk_act_spk_activity_id"
  add_foreign_key "activities_speakers", "contacts", name: "fk_act_spk_contact_id"
  add_foreign_key "areas", "contacts", column: "head_id", name: "fk_area_head"
  add_foreign_key "areas_interests", "activities", name: "fk_area_int_activity_id"
  add_foreign_key "areas_interests", "areas", name: "fk_area_int_area_id"
  add_foreign_key "areas_organizations", "areas", name: "fk_area_org_area_id"
  add_foreign_key "areas_organizations", "organizations", name: "fk_area_org_organization_id"
  add_foreign_key "areas_resource_containers", "areas", name: "fk_ar_area_id"
  add_foreign_key "areas_resource_containers", "resource_containers", name: "fk_ar_resource_id"
  add_foreign_key "bookings", "activities", name: "fk_book_activity"
  add_foreign_key "bookings", "users", name: "fk_book_user"
  add_foreign_key "resource_containers_resources", "resource_containers", name: "fk_res_res_c_id"
  add_foreign_key "resource_containers_resources", "resources", name: "fk_res_res_id"
end
