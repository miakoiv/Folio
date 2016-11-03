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

ActiveRecord::Schema.define(version: 20161103093817) do

  create_table "documents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string   "documentable_type",               null: false
    t.integer  "documentable_id",                 null: false
    t.text     "attachment_data",   limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["documentable_type", "documentable_id"], name: "index_documents_on_documentable_type_and_documentable_id", using: :btree
  end

  create_table "education_levels", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string  "name_fi",                    null: false
    t.boolean "needs_info", default: false, null: false
  end

  create_table "event_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string "name_fi"
    t.string "appearance"
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer  "liaison_id",                                  null: false
    t.integer  "event_type_id",                               null: false
    t.datetime "starts_at",                                   null: false
    t.datetime "ends_at"
    t.boolean  "all_day",                     default: false, null: false
    t.string   "title",                                       null: false
    t.text     "description",   limit: 65535
    t.integer  "creator_id",                                  null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.index ["creator_id"], name: "index_events_on_creator_id", using: :btree
    t.index ["event_type_id"], name: "index_events_on_event_type_id", using: :btree
    t.index ["liaison_id"], name: "index_events_on_liaison_id", using: :btree
  end

  create_table "images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string   "imageable_type",                null: false
    t.integer  "imageable_id",                  null: false
    t.text     "attachment_data", limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id", using: :btree
  end

  create_table "liaisons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer  "user_id",                   null: false
    t.integer  "person_id",                 null: false
    t.integer  "status_id",     default: 0, null: false
    t.integer  "referrer_id"
    t.string   "referrer_info"
    t.integer  "creator_id",                null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["creator_id"], name: "index_liaisons_on_creator_id", using: :btree
    t.index ["person_id"], name: "index_liaisons_on_person_id", using: :btree
    t.index ["referrer_id"], name: "index_liaisons_on_referrer_id", using: :btree
    t.index ["status_id"], name: "index_liaisons_on_status_id", using: :btree
    t.index ["user_id"], name: "index_liaisons_on_user_id", using: :btree
  end

  create_table "memos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer  "unit_id",                  null: false
    t.string   "title"
    t.text     "content",    limit: 65535
    t.integer  "creator_id",               null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["creator_id"], name: "index_memos_on_creator_id", using: :btree
    t.index ["unit_id"], name: "index_memos_on_unit_id", using: :btree
  end

  create_table "memos_recipients", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer "memo_id",      null: false
    t.integer "recipient_id", null: false
    t.index ["recipient_id", "memo_id"], name: "index_memos_recipients_on_recipient_id_and_memo_id", unique: true, using: :btree
  end

  create_table "memos_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer "memo_id", null: false
    t.integer "user_id", null: false
    t.index ["user_id", "memo_id"], name: "index_memos_users_on_user_id_and_memo_id", unique: true, using: :btree
  end

  create_table "municipalities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string "name_fi", null: false
    t.string "name_sv", null: false
  end

  create_table "notes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer  "liaison_id",               null: false
    t.string   "title"
    t.text     "content",    limit: 65535
    t.integer  "creator_id",               null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["creator_id"], name: "index_notes_on_creator_id", using: :btree
    t.index ["liaison_id"], name: "index_notes_on_liaison_id", using: :btree
  end

  create_table "people", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string   "identification",               null: false
    t.date     "date_of_birth"
    t.string   "last_name"
    t.string   "first_names"
    t.string   "gender",             limit: 1
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.string   "postcode_id",        limit: 5
    t.integer  "municipality_id"
    t.string   "language",           limit: 2
    t.string   "nationality",        limit: 2
    t.integer  "education_level_id"
    t.string   "education_info"
    t.string   "accommodation"
    t.string   "disabilities"
    t.integer  "creator_id",                   null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["creator_id"], name: "index_people_on_creator_id", using: :btree
    t.index ["education_level_id"], name: "index_people_on_education_level_id", using: :btree
    t.index ["identification"], name: "index_people_on_identification", using: :btree
    t.index ["last_name"], name: "index_people_on_last_name", using: :btree
    t.index ["municipality_id"], name: "index_people_on_municipality_id", using: :btree
    t.index ["postcode_id"], name: "index_people_on_postcode_id", using: :btree
  end

  create_table "postcodes", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string  "code",            limit: 5, null: false
    t.string  "name_fi",                   null: false
    t.string  "name_sv",                   null: false
    t.integer "municipality_id",           null: false
    t.index ["code"], name: "index_postcodes_on_code", using: :btree
    t.index ["municipality_id"], name: "index_postcodes_on_municipality_id", using: :btree
  end

  create_table "referrers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string  "name_fi",                    null: false
    t.boolean "needs_info", default: false, null: false
  end

  create_table "statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string "name_fi",    null: false
    t.string "appearance", null: false
  end

  create_table "units", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string   "name_fi",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "locale"
    t.integer  "unit_id",                             null: false
    t.string   "last_name"
    t.string   "first_names"
    t.date     "activates_at"
    t.date     "expires_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unit_id"], name: "index_users_on_unit_id", using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

end
