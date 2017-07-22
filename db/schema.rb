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

ActiveRecord::Schema.define(version: 20170722220951) do

  create_table "assistantships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "assistant_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["assistant_id"], name: "index_assistantships_on_assistant_id"
    t.index ["user_id"], name: "index_assistantships_on_user_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.text     "description",       null: false
    t.string   "url",               null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "medical_record_id"
    t.index ["medical_record_id"], name: "index_attachments_on_medical_record_id"
  end

  create_table "backgrounds", force: :cascade do |t|
    t.string   "background_type",   null: false
    t.text     "description",       null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "medical_record_id"
    t.index ["medical_record_id"], name: "index_backgrounds_on_medical_record_id"
  end

  create_table "consultations", force: :cascade do |t|
    t.integer  "medical_record_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.text     "evolution"
    t.text     "note"
    t.text     "affliction"
    t.float    "weight"
    t.float    "height"
    t.integer  "diagnostic_id"
    t.integer  "reason_id"
    t.string   "pressure_s"
    t.string   "pressure_d"
    t.integer  "plan_id"
    t.index ["diagnostic_id"], name: "index_consultations_on_diagnostic_id"
    t.index ["medical_record_id"], name: "index_consultations_on_medical_record_id"
    t.index ["plan_id"], name: "index_consultations_on_plan_id"
    t.index ["reason_id"], name: "index_consultations_on_reason_id"
  end

  create_table "diagnostics", force: :cascade do |t|
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

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
    t.date     "birthday"
    t.index ["insurance_id"], name: "index_medical_records_on_insurance_id"
    t.index ["occupation_id"], name: "index_medical_records_on_occupation_id"
  end

  create_table "medicines", force: :cascade do |t|
    t.string   "comercial_name"
    t.string   "generic_name",   null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "occupations", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "operative_notes", force: :cascade do |t|
    t.text     "description", null: false
    t.text     "find"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "plan_id"
    t.text     "diagnostic"
    t.index ["plan_id"], name: "index_operative_notes_on_plan_id"
  end

  create_table "physical_exams", force: :cascade do |t|
    t.string   "exam_type",       null: false
    t.string   "url",             null: false
    t.text     "observation"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "consultation_id"
    t.index ["consultation_id"], name: "index_physical_exams_on_consultation_id"
  end

  create_table "plan_procedures", force: :cascade do |t|
    t.integer  "plan_id"
    t.integer  "procedure_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["plan_id"], name: "index_plan_procedures_on_plan_id"
    t.index ["procedure_id"], name: "index_plan_procedures_on_procedure_id"
  end

  create_table "plans", force: :cascade do |t|
    t.text     "description",       null: false
    t.boolean  "emergency"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "consultation_id"
    t.integer  "operative_note_id"
    t.index ["consultation_id"], name: "index_plans_on_consultation_id"
    t.index ["operative_note_id"], name: "index_plans_on_operative_note_id"
  end

  create_table "prescription_medicines", force: :cascade do |t|
    t.integer  "prescription_id"
    t.integer  "medicine_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "dose_way",          null: false
    t.string   "dose_presentation", null: false
    t.float    "dose_quantity",     null: false
    t.string   "dose_unit",         null: false
    t.float    "interval_quantity", null: false
    t.string   "interval_unit",     null: false
    t.float    "duration_quantity", null: false
    t.string   "duration_unit",     null: false
    t.string   "note"
    t.float    "interval_time",     null: false
    t.index ["medicine_id"], name: "index_prescription_medicines_on_medicine_id"
    t.index ["prescription_id"], name: "index_prescription_medicines_on_prescription_id"
  end

  create_table "prescriptions", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "medical_record_id"
    t.index ["medical_record_id"], name: "index_prescriptions_on_medical_record_id"
  end

  create_table "procedures", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "reasons", force: :cascade do |t|
    t.text     "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "reports", force: :cascade do |t|
    t.string   "report_type",       null: false
    t.text     "description",       null: false
    t.integer  "medical_record_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["medical_record_id"], name: "index_reports_on_medical_record_id"
  end

  create_table "syncs", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "sync_date"
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
    t.string   "avatar"
    t.index ["auth_token"], name: "index_users_on_auth_token"
    t.index ["document"], name: "index_users_on_document", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
