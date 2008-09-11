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

ActiveRecord::Schema.define(:version => 20080909172302) do

  create_table "addresses", :force => true do |t|
    t.string   "context",      :default => "Work", :null => false
    t.string   "full_address",                     :null => false
    t.string   "thoroughfare"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.integer  "ordinal",      :default => 0,      :null => false
    t.integer  "client_id",                        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "firstname"
    t.string   "lastname"
    t.boolean  "company",    :default => false, :null => false
    t.integer  "belongs_to"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "components", :force => true do |t|
    t.string   "name"
    t.string   "serial_number"
    t.integer  "device_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "service_tag"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emails", :force => true do |t|
    t.string   "context",    :default => "Work", :null => false
    t.string   "address"
    t.integer  "ordinal",    :default => 0,      :null => false
    t.integer  "client_id",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phones", :force => true do |t|
    t.string   "context",    :default => "Work", :null => false
    t.string   "number"
    t.integer  "ordinal",    :default => 0,      :null => false
    t.integer  "client_id",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", :force => true do |t|
    t.string   "name"
    t.string   "serial_number"
    t.integer  "device_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", :force => true do |t|
    t.integer  "client_id"
    t.string   "group"
    t.integer  "user_id"
    t.text     "description"
    t.string   "status"
    t.date     "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
