# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_05_090505) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.integer "assigner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "auxiliary_records", force: :cascade do |t|
    t.integer "auxiliary_table_id"
    t.string "uuid"
    t.json "data_record"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.integer "document_id"
  end

  create_table "auxiliary_tables", force: :cascade do |t|
    t.string "title"
    t.json "data_format"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "table_type"
  end

  create_table "documents", force: :cascade do |t|
    t.string "title"
    t.text "abstract"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "draft"
    t.integer "workflow_state_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "surename"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
    t.text "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workflow_states", force: :cascade do |t|
    t.string "title"
    t.integer "workflow_id"
    t.integer "node_id"
    t.json "node_attr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workflow_tables", force: :cascade do |t|
    t.integer "workflow_id"
    t.integer "auxiliary_table_id"
    t.integer "rank", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workflows", force: :cascade do |t|
    t.string "title"
    t.text "details"
    t.json "graph"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workfolw_tables", force: :cascade do |t|
    t.integer "workflow_d"
    t.integer "auxiliary_table_id"
    t.integer "rank", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
