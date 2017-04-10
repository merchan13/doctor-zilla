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

ActiveRecord::Schema.define(version: 20170410184513) do

  create_table "insurances", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "medical_records", force: :cascade do |t|
    t.string   "document",                null: false
    t.string   "document_type",           null: false
    t.datetime "first_consultation_date", null: false
    t.string   "name",                    null: false
    t.string   "last_name",               null: false
    t.datetime "birth_date",              null: false
    t.string   "gender",                  null: false
    t.string   "phone_number"
    t.string   "cellphone_number"
    t.text     "address",                 null: false
    t.string   "email"
    t.string   "referred_by",             null: false
    t.string   "profile_picture"
    t.string   "representative_document"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "occupation_id"
    t.integer  "insurance_id"
    t.index ["insurance_id"], name: "index_medical_records_on_insurance_id"
    t.index ["occupation_id"], name: "index_medical_records_on_occupation_id"
  end

  create_table "occupations", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_medical_records", force: :cascade do |t|
    t.integer  "user_id",           null: false
    t.integer  "medical_record_id", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "document",                            null: false
    t.string   "name",                                null: false
    t.string   "lastname",                            null: false
    t.string   "phone",                               null: false
    t.string   "role",                                null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "auth_token"
    t.index ["auth_token"], name: "index_users_on_auth_token"
    t.index ["document"], name: "index_users_on_document", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
