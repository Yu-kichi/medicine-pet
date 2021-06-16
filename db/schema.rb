# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_16_090322) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clinics", force: :cascade do |t|
    t.string "name", null: false
    t.date "prescription_date", null: false
    t.string "doctor_name"
    t.integer "medical_fee"
    t.integer "medicine_fee"
    t.text "memo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "pet_id"
    t.index ["pet_id"], name: "index_clinics_on_pet_id"
  end

  create_table "medicines", force: :cascade do |t|
    t.string "name", null: false
    t.string "quantity", null: false
    t.text "memo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "clinic_id"
    t.bigint "pet_id"
    t.index ["clinic_id"], name: "index_medicines_on_clinic_id"
    t.index ["pet_id"], name: "index_medicines_on_pet_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "name", null: false
    t.integer "sex"
    t.string "breed"
    t.float "weight"
    t.date "birthday"
    t.text "memo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_pets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "clinics", "pets"
  add_foreign_key "medicines", "pets"
  add_foreign_key "pets", "users"
end
