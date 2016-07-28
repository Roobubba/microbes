# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160728141743) do

  create_table "microbes", force: :cascade do |t|
    t.string  "link"
    t.string  "name"
    t.integer "cost"
    t.string  "fullname"
    t.integer "morphology_id"
    t.string  "picture"
    t.string  "attachment"
    t.string  "androidattachment"
  end

  create_table "morphologies", force: :cascade do |t|
    t.string "morphology"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.integer  "microbes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uniqueid"
    t.string   "email"
    t.boolean  "admin",           default: false
    t.integer  "currency"
    t.string   "platform",        default: "Windows"
  end

end
