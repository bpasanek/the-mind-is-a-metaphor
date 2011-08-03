# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090902182601) do

  create_table "author_works", :force => true do |t|
    t.integer  "author_id",  :default => 0, :null => false
    t.integer  "work_id",    :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "author_works", ["author_id", "work_id"], :name => "index_author_works_on_author_id_and_work_id"
  add_index "author_works", ["work_id"], :name => "index_author_works_on_work_id"

  create_table "authors", :force => true do |t|
    t.text     "name",           :limit => 255,                     :null => false
    t.text     "last_name",      :limit => 255
    t.text     "first_name",     :limit => 255
    t.string   "gender",                        :default => "Male", :null => false
    t.text     "date_of_birth",  :limit => 255
    t.text     "date_of_death",  :limit => 255
    t.integer  "occupation_id"
    t.integer  "religion_id"
    t.integer  "politic_id"
    t.integer  "nationality_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classifications", :force => true do |t|
    t.text     "value"
    t.string   "classifiable_type"
    t.integer  "classifiable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "classifications", ["classifiable_id"], :name => "index_classifications_on_classifiable_id"

  create_table "metaphors", :force => true do |t|
    t.integer  "work_id"
    t.text     "metaphor",                   :null => false
    t.text     "text"
    t.text     "context"
    t.text     "provenance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "theme",       :limit => 255
    t.text     "comments"
    t.text     "dictionary",  :limit => 255
    t.date     "reviewed_on"
  end

  create_table "nationalities", :force => true do |t|
    t.text     "name",       :limit => 255, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "occupations", :force => true do |t|
    t.text     "name",       :limit => 255, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "politics", :force => true do |t|
    t.text     "grouping",   :limit => 255
    t.text     "name",       :limit => 255, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "religions", :force => true do |t|
    t.text     "grouping",   :limit => 255
    t.text     "name",       :limit => 255, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "types", :force => true do |t|
    t.integer  "metaphor_id"
    t.text     "name",        :limit => 255, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "works", :force => true do |t|
    t.text     "title",                                    :null => false
    t.text     "year",                 :limit => 255
    t.integer  "year_integer",         :limit => 2
    t.text     "printer"
    t.text     "place_of_publication", :limit => 255
    t.text     "citation"
    t.text     "composed",             :limit => 255
    t.text     "notes",                :limit => 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "works", ["year_integer"], :name => "YearSort"

end
