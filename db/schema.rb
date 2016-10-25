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

ActiveRecord::Schema.define(version: 20161025115603) do

  create_table "education_levels", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string  "name_fi",                    null: false
    t.boolean "needs_info", default: false, null: false
  end

  create_table "images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string   "imageable_type",                null: false
    t.integer  "imageable_id",                  null: false
    t.text     "attachment_data", limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id", using: :btree
  end

  create_table "municipalities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string "name_fi", null: false
    t.string "name_sv", null: false
  end

  create_table "patronages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer  "unit_id",                                 null: false
    t.integer  "person_id",                               null: false
    t.integer  "status",                      default: 0, null: false
    t.integer  "referrer_id",                             null: false
    t.string   "referrer_info"
    t.text     "notes",         limit: 65535
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["person_id"], name: "index_patronages_on_person_id", using: :btree
    t.index ["referrer_id"], name: "index_patronages_on_referrer_id", using: :btree
    t.index ["unit_id"], name: "index_patronages_on_unit_id", using: :btree
  end

  create_table "people", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string   "identification",                   null: false
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
    t.text     "restrictions",       limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
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

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "locale"
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
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

end
