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

ActiveRecord::Schema.define(:version => 20130228134736) do

  create_table "connections", :force => true do |t|
    t.integer  "terminal_id"
    t.string   "user"
    t.integer  "port"
    t.string   "protocol"
    t.string   "credentials"
    t.string   "certificate_file_name"
    t.string   "certificate_content_type"
    t.integer  "certificate_file_size"
    t.datetime "certificate_updated_at"
  end

  create_table "heads", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "heads", ["email"], :name => "index_heads_on_email", :unique => true
  add_index "heads", ["reset_password_token"], :name => "index_heads_on_reset_password_token", :unique => true

  create_table "organizations", :force => true do |t|
    t.integer "head_id"
    t.string  "name"
    t.string  "subdomain"
  end

  create_table "remote_sessions", :force => true do |t|
    t.integer "pid",           :null => false
    t.string  "host"
    t.integer "port"
    t.integer "connection_id"
  end

  create_table "terminals", :force => true do |t|
    t.string  "name",            :null => false
    t.string  "uri",             :null => false
    t.integer "organization_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",     :null => false
    t.string   "encrypted_password",     :default => "",     :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "organization_id"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "role",                   :default => "user", :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_connections", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "connection_id"
  end

end
