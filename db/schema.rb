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

ActiveRecord::Schema[7.1].define(version: 2024_09_27_122412) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "secret_groups", id: false, force: :cascade do |t|
    t.string "name", null: false
    t.string "owner", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "owner"], name: "index_secret_groups_on_name_and_owner", unique: true
  end

  create_table "secrets", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "value", null: false
    t.bigint "interval", default: 30000000, null: false
    t.boolean "is_google", default: false, null: false
    t.integer "length", default: 6, null: false
    t.string "group_name", null: false
    t.string "owner", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_name", "owner"], name: "index_secrets_on_group_name_and_owner"
  end

  create_table "users", id: false, force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "verified", default: false, null: false
    t.string "default_group_name", default: "All", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "secret_groups", "users", column: "owner", primary_key: "name", on_update: :cascade, on_delete: :cascade
  add_foreign_key "secrets", "secret_groups", column: ["group_name", "owner"], primary_key: ["name", "owner"], on_update: :cascade, on_delete: :cascade
end
