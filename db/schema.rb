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

ActiveRecord::Schema.define(version: 20170410071942) do

  create_table "activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer  "unit_id",                     null: false
    t.integer  "whodunnit_id",                null: false
    t.string   "action"
    t.string   "resource_type",               null: false
    t.integer  "resource_id",                 null: false
    t.string   "context_type",                null: false
    t.integer  "context_id",                  null: false
    t.text     "differences",   limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["context_type", "context_id"], name: "index_activities_on_context_type_and_context_id", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_activities_on_resource_type_and_resource_id", using: :btree
    t.index ["unit_id"], name: "index_activities_on_unit_id", using: :btree
    t.index ["whodunnit_id"], name: "index_activities_on_whodunnit_id", using: :btree
  end

  create_table "collections", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer  "memo_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["memo_id", "user_id"], name: "index_collections_on_memo_id_and_user_id", unique: true, using: :btree
    t.index ["memo_id"], name: "index_collections_on_memo_id", using: :btree
    t.index ["user_id"], name: "index_collections_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer  "post_id",                  null: false
    t.integer  "author_id",                null: false
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["author_id"], name: "index_comments_on_author_id", using: :btree
    t.index ["post_id"], name: "index_comments_on_post_id", using: :btree
  end

  create_table "customers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer  "unit_id",                   null: false
    t.integer  "person_id",                 null: false
    t.integer  "status_id",     default: 0, null: false
    t.integer  "referrer_id"
    t.string   "referrer_info"
    t.date     "started_at",                null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["person_id"], name: "index_customers_on_person_id", using: :btree
    t.index ["referrer_id"], name: "index_customers_on_referrer_id", using: :btree
    t.index ["status_id"], name: "index_customers_on_status_id", using: :btree
    t.index ["unit_id"], name: "index_customers_on_unit_id", using: :btree
  end

  create_table "customers_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer "customer_id", null: false
    t.integer "user_id",     null: false
    t.index ["customer_id", "user_id"], name: "index_customers_users_on_customer_id_and_user_id", using: :btree
  end

  create_table "deliveries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer  "memo_id",        null: false
    t.string   "recipient_type", null: false
    t.integer  "recipient_id",   null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["memo_id"], name: "index_deliveries_on_memo_id", using: :btree
    t.index ["recipient_type", "recipient_id"], name: "index_deliveries_on_recipient_type_and_recipient_id", using: :btree
  end

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
    t.integer "event_scope", default: 0, null: false
    t.string  "name_fi"
    t.string  "appearance"
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer  "unit_id",                     null: false
    t.integer  "user_id",                     null: false
    t.integer  "customer_id"
    t.integer  "event_type_id",               null: false
    t.datetime "starts_at",                   null: false
    t.integer  "duration",                    null: false
    t.datetime "ends_at"
    t.string   "title",                       null: false
    t.text     "description",   limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.datetime "deleted_at"
    t.index ["customer_id"], name: "index_events_on_customer_id", using: :btree
    t.index ["event_type_id"], name: "index_events_on_event_type_id", using: :btree
    t.index ["unit_id"], name: "index_events_on_unit_id", using: :btree
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

  create_table "images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string   "imageable_type",                null: false
    t.integer  "imageable_id",                  null: false
    t.text     "attachment_data", limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id", using: :btree
  end

  create_table "memos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer  "sender_id",                null: false
    t.string   "icon"
    t.string   "title"
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["sender_id"], name: "index_memos_on_sender_id", using: :btree
  end

  create_table "milestone_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string   "name_fi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "milestones", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer  "milestone_type_id", null: false
    t.string   "name_fi"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["milestone_type_id"], name: "index_milestones_on_milestone_type_id", using: :btree
  end

  create_table "municipalities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string "name_fi", null: false
    t.string "name_sv", null: false
  end

  create_table "notes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer  "user_id",                   null: false
    t.integer  "customer_id"
    t.string   "title"
    t.text     "content",     limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["customer_id"], name: "index_notes_on_customer_id", using: :btree
    t.index ["user_id"], name: "index_notes_on_user_id", using: :btree
  end

  create_table "people", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string   "identification"
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
    t.text     "notes",              limit: 65535
    t.integer  "children_count",                   default: 0, null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["children_count"], name: "index_people_on_children_count", using: :btree
    t.index ["education_level_id"], name: "index_people_on_education_level_id", using: :btree
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

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer  "unit_id",                  null: false
    t.integer  "author_id",                null: false
    t.string   "title"
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["author_id"], name: "index_posts_on_author_id", using: :btree
    t.index ["unit_id"], name: "index_posts_on_unit_id", using: :btree
  end

  create_table "referrers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string  "name_fi",                    null: false
    t.boolean "needs_info", default: false, null: false
  end

  create_table "relations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string "name_fi"
  end

  create_table "relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer  "person_id",                      null: false
    t.integer  "parent_id",                      null: false
    t.integer  "relation_id",                    null: false
    t.boolean  "legal_guardian", default: false, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["parent_id"], name: "index_relationships_on_parent_id", using: :btree
    t.index ["person_id"], name: "index_relationships_on_person_id", using: :btree
    t.index ["relation_id"], name: "index_relationships_on_relation_id", using: :btree
  end

  create_table "reviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer  "user_id",                    null: false
    t.integer  "customer_id",                null: false
    t.string   "title"
    t.text     "content",      limit: 65535
    t.date     "published_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["customer_id"], name: "index_reviews_on_customer_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.boolean "active",     default: false, null: false
    t.string  "name_fi",                    null: false
    t.string  "appearance",                 null: false
  end

  create_table "steps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer  "customer_id",                null: false
    t.integer  "milestone_id",               null: false
    t.date     "reached_at",                 null: false
    t.text     "notes",        limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["customer_id"], name: "index_steps_on_customer_id", using: :btree
    t.index ["milestone_id"], name: "index_steps_on_milestone_id", using: :btree
  end

  create_table "templates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer  "unit_id",                  null: false
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["unit_id"], name: "index_templates_on_unit_id", using: :btree
  end

  create_table "units", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string   "name_fi",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.string   "email",                         default: "",    null: false
    t.string   "locale"
    t.integer  "unit_id",                                       null: false
    t.string   "last_name"
    t.string   "first_names"
    t.date     "activates_at"
    t.date     "expires_at"
    t.boolean  "two_factor_enabled",            default: false, null: false
    t.boolean  "unconfirmed_two_factor",        default: false, null: false
    t.integer  "second_factor_attempts_count",  default: 0
    t.string   "encrypted_otp_secret_key"
    t.string   "encrypted_otp_secret_key_iv"
    t.string   "encrypted_otp_secret_key_salt"
    t.string   "direct_otp"
    t.datetime "direct_otp_sent_at"
    t.datetime "totp_timestamp"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "encrypted_password",            default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                 default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",               default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["encrypted_otp_secret_key"], name: "index_users_on_encrypted_otp_secret_key", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unit_id"], name: "index_users_on_unit_id", using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci" do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

end
