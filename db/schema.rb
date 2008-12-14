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

ActiveRecord::Schema.define(:version => 20081212174923) do

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

  create_table "checklist_items", :force => true do |t|
    t.integer  "checklist_id",                       :null => false
    t.text     "question",                           :null => false
    t.string   "answer_type",  :default => "string", :null => false
    t.binary   "binary"
    t.boolean  "boolean"
    t.date     "date"
    t.datetime "datetime"
    t.decimal  "decimal"
    t.float    "float"
    t.integer  "integer"
    t.string   "string"
    t.text     "text"
    t.time     "time"
    t.boolean  "completed",    :default => false,    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checklist_template_questions", :force => true do |t|
    t.integer  "checklist_template_id"
    t.string   "answer_type"
    t.text     "question"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checklist_templates", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checklist_templates_device_types", :id => false, :force => true do |t|
    t.integer "checklist_template_id", :null => false
    t.integer "device_type_id",        :null => false
  end

  create_table "checklists", :force => true do |t|
    t.integer  "checklist_template_id"
    t.string   "name"
    t.integer  "ticket_id"
    t.integer  "device_id"
    t.boolean  "completed"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "firstname"
    t.string   "lastname"
    t.boolean  "company",              :null => false
    t.integer  "belongs_to"
    t.text     "note"
    t.string   "mugshot_file_name"
    t.string   "mugshot_content_type"
    t.integer  "mugshot_file_size"
    t.string   "qb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "device_types", :force => true do |t|
    t.string   "description"
    t.string   "identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices", :force => true do |t|
    t.string   "service_tag"
    t.string   "name"
    t.text     "description"
    t.integer  "device_type_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices_tickets", :id => false, :force => true do |t|
    t.integer "ticket_id", :null => false
    t.integer "device_id", :null => false
  end

  create_table "emails", :force => true do |t|
    t.string   "context",    :default => "Work", :null => false
    t.string   "address"
    t.integer  "ordinal",    :default => 0,      :null => false
    t.integer  "client_id",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "recordable_type"
    t.integer  "recordable_id"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goggles", :force => true do |t|
    t.string "name"
    t.string "script"
    t.text   "note"
  end

  create_table "notification_queues", :force => true do |t|
    t.text    "message"
    t.integer "schedule_id"
  end

  create_table "passwords", :force => true do |t|
    t.integer  "user_id"
    t.string   "reset_code"
    t.datetime "expiration_date"
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

  create_table "preferences", :force => true do |t|
    t.string   "attribute",  :null => false
    t.integer  "owner_id",   :null => false
    t.string   "owner_type", :null => false
    t.integer  "group_id"
    t.string   "group_type"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "preferences", ["attribute", "group_id", "group_type", "owner_id", "owner_type"], :name => "index_preferences_on_owner_and_attribute_and_preference", :unique => true

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "schedules", :force => true do |t|
    t.string  "name"
    t.boolean "active"
    t.integer "user_id"
    t.string  "start_time"
    t.string  "end_time"
    t.integer "backup_id"
  end

  create_table "sentries", :force => true do |t|
    t.boolean  "state"
    t.text     "message"
    t.integer  "device_id"
    t.string   "goggle_parameters"
    t.datetime "last_surveyed_at"
    t.integer  "survey_interval"
    t.integer  "notifications_to_send"
    t.integer  "maximum_notify_frequency"
    t.integer  "notifications_sent"
    t.integer  "schedule_id"
    t.integer  "goggle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "things", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.integer  "user_id"
    t.integer  "attached_id"
    t.string   "attached_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_entries", :force => true do |t|
    t.string   "entry_type"
    t.text     "note"
    t.integer  "time"
    t.boolean  "billable"
    t.boolean  "private"
    t.integer  "detail"
    t.integer  "creator_id"
    t.integer  "ticket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "labor_type"
    t.string   "parts"
  end

  create_table "tickets", :force => true do |t|
    t.integer  "client_id"
    t.integer  "user_id"
    t.text     "description"
    t.date     "active_on"
    t.date     "completed_on"
    t.date     "archived_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token",            :limit => 40
    t.string   "activation_code",           :limit => 40
    t.string   "state",                                    :default => "passive"
    t.datetime "remember_token_expires_at"
    t.datetime "activated_at"
    t.datetime "deleted_at"
    t.integer  "client_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
