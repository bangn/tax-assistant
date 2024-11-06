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

ActiveRecord::Schema[7.2].define(version: 2024_11_06_051227) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "receipts", force: :cascade do |t|
    t.string "receipt_number"
    t.integer "total_amount", null: false
    t.string "seller"
    t.string "note"
    t.date "date"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_receipts_on_date"
    t.index ["receipt_number"], name: "index_receipts_on_receipt_number"
    t.index ["seller"], name: "index_receipts_on_seller"
    t.index ["total_amount"], name: "index_receipts_on_total_amount"
    t.index ["user_id"], name: "index_receipts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "given_name"
    t.string "last_name"
    t.string "username"
    t.string "email"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["uid"], name: "index_users_on_uid", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "receipts", "users"
end
