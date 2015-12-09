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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20151116064608) do

  create_table "arimas", :force => true do |t|
    t.integer  "num"
    t.float    "ar1"
    t.float    "ar2"
    t.float    "ar3"
    t.float    "ma1"
    t.float    "ma2"
    t.float    "ma3"
    t.string   "arima_ar"
    t.float    "intercept"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "news", :force => true do |t|
    t.integer  "num"
    t.date     "date"
    t.string   "title"
    t.string   "contents"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "prices", :force => true do |t|
    t.integer  "num"
    t.date     "date"
    t.float    "start"
    t.float    "high"
    t.float    "low"
    t.float    "sprice"
    t.float    "volume"
    t.float    "aprice"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "results", :id => false, :force => true do |t|
    t.integer  "num"
    t.date     "date"
    t.float    "prob"
    t.float    "ratio"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stocks", :force => true do |t|
    t.integer  "num"
    t.string   "market"
    t.string   "name"
    t.string   "business"
    t.string   "fb"
    t.string   "tw"
    t.string   "hp"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "words", :id => false, :force => true do |t|
    t.integer  "num"
    t.date     "date"
    t.integer  "A"
    t.integer  "B"
    t.integer  "C"
    t.integer  "D"
    t.integer  "E"
    t.integer  "F"
    t.integer  "G"
    t.integer  "H"
    t.integer  "I"
    t.integer  "J"
    t.integer  "K"
    t.integer  "L"
    t.integer  "M"
    t.integer  "N"
    t.integer  "O"
    t.integer  "P"
    t.integer  "Q"
    t.integer  "R"
    t.integer  "S"
    t.integer  "T"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
