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

ActiveRecord::Schema[8.1].define(version: 2026_03_07_061231) do
  create_table "payees", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statements", force: :cascade do |t|
    t.integer "amount", null: false
    t.integer "charged_to", null: false
    t.datetime "created_at", null: false
    t.date "date", null: false
    t.string "description", null: false
    t.integer "paid_by", null: false
    t.integer "payee_id"
    t.datetime "updated_at", null: false
    t.index ["charged_to"], name: "index_statements_on_charged_to"
    t.index ["date"], name: "index_statements_on_date"
    t.index ["paid_by"], name: "index_statements_on_paid_by"
    t.index ["payee_id"], name: "index_statements_on_payee_id"
    t.check_constraint "amount > 0", name: "amount_positive"
    t.check_constraint "paid_by != charged_to", name: "paid_by_not_equal_to_charged_to"
  end

  add_foreign_key "statements", "payees"
end
