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

ActiveRecord::Schema.define(version: 2021_06_08_053540) do

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
    t.index ["clinic_id"], name: "index_medicines_on_clinic_id"
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
  end

  add_foreign_key "clinics", "pets"
  add_foreign_key "medicines", "clinics"
end
