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

ActiveRecord::Schema[8.0].define(version: 2025_03_04_125002) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pg_trgm"

  create_table "connections", force: :cascade do |t|
    t.bigint "user_a_id", null: false
    t.bigint "user_b_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_a_id", "user_b_id"], name: "index_connections_on_user_a_id_and_user_b_id", unique: true
    t.index ["user_a_id"], name: "index_connections_on_user_a_id"
    t.index ["user_b_id"], name: "index_connections_on_user_b_id"
  end

  create_table "contractor_trades", force: :cascade do |t|
    t.bigint "contractor_id", null: false
    t.bigint "trade_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contractor_id"], name: "index_contractor_trades_on_contractor_id"
    t.index ["trade_id"], name: "index_contractor_trades_on_trade_id"
  end

  create_table "contractors", force: :cascade do |t|
    t.bigint "added_by_id", null: false
    t.bigint "updated_by_id"
    t.string "name", null: false
    t.string "company_name"
    t.string "number", null: false
    t.string "email"
    t.string "town", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["added_by_id"], name: "index_contractors_on_added_by_id"
    t.index ["email"], name: "index_contractors_on_email", unique: true
    t.index ["number"], name: "index_contractors_on_number", unique: true
    t.index ["updated_by_id"], name: "index_contractors_on_updated_by_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "contractor_id", null: false
    t.text "description"
    t.string "state"
    t.string "town"
    t.date "start_date"
    t.date "end_date"
    t.float "cost"
    t.text "review"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contractor_id"], name: "index_jobs_on_contractor_id"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "contractor_id", null: false
    t.text "review"
    t.float "overall_rating"
    t.float "value_rating"
    t.float "communication_rating"
    t.float "quality_rating"
    t.float "tidiness_rating"
    t.float "professionalism_rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contractor_id"], name: "index_ratings_on_contractor_id"
    t.index ["user_id", "contractor_id"], name: "index_ratings_on_user_id_and_contractor_id", unique: true
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "trades", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_trades_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "town"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "connections", "users", column: "user_a_id"
  add_foreign_key "connections", "users", column: "user_b_id"
  add_foreign_key "contractor_trades", "contractors"
  add_foreign_key "contractor_trades", "trades"
  add_foreign_key "contractors", "users", column: "added_by_id"
  add_foreign_key "contractors", "users", column: "updated_by_id"
  add_foreign_key "jobs", "contractors"
  add_foreign_key "jobs", "users"
  add_foreign_key "ratings", "contractors"
  add_foreign_key "ratings", "users"
end
