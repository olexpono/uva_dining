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

ActiveRecord::Schema.define(:version => 20101026091048) do

  create_table "dining_halls", :force => true do |t|
    t.boolean  "open"
    t.string   "meal"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "food_items", :force => true do |t|
    t.string   "nutrition_url"
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meal_times", :force => true do |t|
    t.datetime "start"
    t.datetime "end"
    t.string   "meal"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dining_hall_id"
  end

  create_table "menu_items", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "meal_time_id"
    t.integer  "food_item_id"
  end

end
