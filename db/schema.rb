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

ActiveRecord::Schema.define(version: 2022_04_03_044412) do

  create_table "cdrs", charset: "utf8mb4", force: :cascade do |t|
    t.datetime "calldate", null: false
    t.string "clid", limit: 80, default: "", null: false
    t.string "src", limit: 80, default: "", null: false
    t.string "dst", limit: 80, default: "", null: false
    t.string "dcontext", limit: 80, default: "", null: false
    t.string "channel", limit: 80, default: "", null: false
    t.string "dstchannel", limit: 80, default: "", null: false
    t.string "lastapp", limit: 80, default: "", null: false
    t.string "lastdata", limit: 256, default: "", null: false
    t.integer "duration", default: 0, null: false
    t.integer "billsec", default: 0, null: false
    t.datetime "start"
    t.datetime "answer"
    t.datetime "end"
    t.string "disposition", limit: 45, default: "", null: false
    t.string "amaflags", limit: 80, default: "", null: false
    t.string "accountcode", limit: 20, default: "", null: false
    t.string "userfield", default: "", null: false
    t.string "uniqueid", limit: 40, default: "", null: false
    t.index ["accountcode"], name: "index_cdrs_on_accountcode"
    t.index ["amaflags"], name: "index_cdrs_on_amaflags"
    t.index ["channel"], name: "index_cdrs_on_channel"
    t.index ["disposition"], name: "index_cdrs_on_disposition"
    t.index ["dst"], name: "index_cdrs_on_dst"
    t.index ["dstchannel"], name: "index_cdrs_on_dstchannel"
    t.index ["duration"], name: "index_cdrs_on_duration"
    t.index ["src"], name: "index_cdrs_on_src"
    t.index ["start"], name: "index_cdrs_on_start"
    t.index ["userfield"], name: "index_cdrs_on_userfield"
  end

  create_table "dials", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.string "sound_url", null: false
    t.boolean "recorded", default: false
    t.string "description", null: false
    t.boolean "dialed", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "record_id"
    t.index ["dialed"], name: "index_dials_on_dialed"
    t.index ["record_id"], name: "index_dials_on_record_id"
    t.index ["user_id"], name: "index_dials_on_user_id"
  end

  create_table "dialstogroups", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "dial_id"
    t.boolean "dialed", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dial_id"], name: "index_dialstogroups_on_dial_id"
    t.index ["dialed"], name: "index_dialstogroups_on_dialed"
    t.index ["group_id", "dial_id"], name: "index_dialstogroups_on_group_id_and_dial_id", unique: true
    t.index ["group_id"], name: "index_dialstogroups_on_group_id"
  end

  create_table "dialstousers", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "dial_id"
    t.boolean "dialed", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dial_id"], name: "index_dialstousers_on_dial_id"
    t.index ["dialed"], name: "index_dialstousers_on_dialed"
    t.index ["user_id", "dial_id"], name: "index_dialstousers_on_user_id_and_dial_id", unique: true
    t.index ["user_id"], name: "index_dialstousers_on_user_id"
  end

  create_table "groups", charset: "utf8mb4", force: :cascade do |t|
    t.text "group"
    t.text "group_description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_groups_on_ancestry"
    t.index ["group"], name: "index_groups_on_group", unique: true, using: :hash
  end

  create_table "logs", charset: "utf8mb4", force: :cascade do |t|
    t.string "status"
    t.string "url"
    t.string "path"
    t.text "user_inspect"
    t.bigint "user_id"
    t.bigint "group_id"
    t.bigint "role_id"
    t.string "rank"
    t.float "time_spent"
    t.string "user_agent"
    t.string "ip"
    t.string "request_method"
    t.string "http_host"
    t.string "exception_class"
    t.text "exception_message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "records", charset: "utf8mb4", force: :cascade do |t|
    t.string "sound_url"
    t.string "description"
    t.boolean "recorded", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["description"], name: "index_records_on_description", unique: true
    t.index ["recorded"], name: "index_records_on_recorded"
  end

  create_table "roles", charset: "utf8mb4", force: :cascade do |t|
    t.string "role"
    t.text "role_description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role"], name: "index_roles_on_role", unique: true
  end

  create_table "rolestorules", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "rule_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id", "rule_id"], name: "index_rolestorules_on_role_id_and_rule_id", unique: true
    t.index ["role_id"], name: "index_rolestorules_on_role_id"
    t.index ["rule_id"], name: "index_rolestorules_on_rule_id"
  end

  create_table "rules", charset: "utf8mb4", force: :cascade do |t|
    t.string "rule"
    t.text "rule_description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rule"], name: "index_rules_on_rule", unique: true
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "phone", null: false
    t.string "phone1", null: false
    t.string "phone2", null: false
    t.string "fio", null: false
    t.string "rank", null: false
    t.string "auth_secret", null: false
    t.string "pincode", default: "91", null: false
    t.boolean "active", default: true
    t.bigint "group_id", null: false
    t.bigint "role_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["active"], name: "index_users_on_active"
    t.index ["group_id"], name: "index_users_on_group_id"
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["phone1"], name: "index_users_on_phone1", unique: true
    t.index ["phone2"], name: "index_users_on_phone2", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "dials", "records"
  add_foreign_key "users", "groups", on_update: :cascade
  add_foreign_key "users", "roles", on_update: :cascade
end
