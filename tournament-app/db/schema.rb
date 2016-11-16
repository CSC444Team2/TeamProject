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

ActiveRecord::Schema.define(version: 20161109215140) do

  create_table "organizes", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "person_id"], name: "index_organizes_on_event_id_and_person_id", unique: true
    t.index ["event_id"], name: "index_organizes_on_event_id"
    t.index ["person_id"], name: "index_organizes_on_person_id"
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

  create_table "tournaments", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "adf"
    t.string   "location"
    t.datetime "date"
    t.string   "contact_email"
    t.string   "contact_name"
    t.text     "description",   limit: 500
  end

  create_table "users", force: :cascade do |t|
    t.text     "first_name"
    t.text     "last_name"
    t.text     "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "reset_digest"
    t.time     "reset_sent_at"
    t.date     "date_of_birth"
    t.string   "gender"
    t.string   "address"
    t.string   "phone_number"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
