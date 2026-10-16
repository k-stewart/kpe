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

ActiveRecord::Schema[8.1].define(version: 2026_10_16_193615) do
  create_table "owners", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "play_dates", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "play_dates_pterosaurs", id: false, force: :cascade do |t|
    t.integer "play_date_id"
    t.integer "pterosaur_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["play_date_id"], name: "index_play_dates_pterosaurs_on_play_date_id"
    t.index ["pterosaur_id"], name: "index_play_dates_pterosaurs_on_pterosaur_id"
  end

  create_table "pterosaurs", force: :cascade do |t|
    t.string "name"
    t.string "species"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_pterosaur_on_owner"
  end

  create_table "vaccination_records", force: :cascade do |t|
    t.string "name"
    t.datetime "due_date"
    t.bigint "pterosaur_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pterosaur_id"], name: "index_vaccinations_on_pterosaur"
  end
end
