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

ActiveRecord::Schema.define(version: 20161206224705) do

  create_table "course_admins", force: :cascade do |t|
    t.integer  "golf_course_id"
    t.integer  "admin_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "course_managers", force: :cascade do |t|
    t.integer  "golf_course_id"
    t.integer  "manager_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "golf_courses", force: :cascade do |t|
    t.text     "name"
    t.text     "overview"
    t.text     "address"
    t.text     "website"
    t.text     "contact_info"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "golf_requests", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.integer  "golf_request_type"
    t.string   "message"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "organizes", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "person_id"], name: "index_organizes_on_event_id_and_person_id", unique: true
    t.index ["event_id"], name: "index_organizes_on_event_id"
    t.index ["person_id"], name: "index_organizes_on_person_id"
  end

  create_table "playergroups", force: :cascade do |t|
    t.text     "group_members"
    t.integer  "tournament_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "plays", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "person_id"], name: "index_plays_on_event_id_and_person_id", unique: true
    t.index ["event_id"], name: "index_plays_on_event_id"
    t.index ["person_id"], name: "index_plays_on_person_id"
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "message"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "sponsors", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "person_id"], name: "index_sponsors_on_event_id_and_person_id", unique: true
    t.index ["event_id"], name: "index_sponsors_on_event_id"
    t.index ["person_id"], name: "index_sponsors_on_person_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "tournament_id"
    t.integer  "user_id"
    t.string   "tickets_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["tournament_id"], name: "index_tickets_on_tournament_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "is_private"
    t.integer  "golf_course_id"
    t.integer  "price"
    t.string   "location"
    t.datetime "date"
    t.string   "contact_email"
    t.string   "contact_name"
    t.text     "description",    limit: 500
  end

  create_table "users", force: :cascade do |t|
    t.text     "first_name"
    t.text     "last_name"
    t.text     "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.date     "date_of_birth"
    t.string   "gender"
    t.string   "address"
    t.string   "phone_number"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "profile_picture_file_name"
    t.string   "profile_picture_content_type"
    t.integer  "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
