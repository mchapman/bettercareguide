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

ActiveRecord::Schema.define(:version => 20120612104105) do

  create_table "address_types", :force => true do |t|
    t.string   "description", :limit => 45, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses", :force => true do |t|
    t.string   "line1",            :limit => 120, :null => false
    t.string   "line2",            :limit => 120
    t.string   "line3",            :limit => 45
    t.string   "city",             :limit => 35,  :null => false
    t.string   "state",            :limit => 30
    t.string   "postal_zip_code",  :limit => 12
    t.integer  "address_type_id",                 :null => false
    t.integer  "organisation_id"
    t.integer  "person_id"
    t.float    "lat"
    t.float    "lng"
    t.integer  "country_id",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "geocoded_by_town"
  end

  add_index "addresses", ["address_type_id"], :name => "fki_address_address_type"
  add_index "addresses", ["organisation_id"], :name => "index_addresses_on_organisation_id"
  add_index "addresses", ["person_id"], :name => "index_addresses_on_person_id"
  add_index "addresses", ["postal_zip_code"], :name => "index_addresses_on_postal_zip_code"

  create_table "comments", :force => true do |t|
    t.float    "rating",                        :null => false
    t.text     "comment_text"
    t.string   "ip_address",      :limit => 15, :null => false
    t.datetime "when",                          :null => false
    t.integer  "public_score_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["person_id"], :name => "index_comments_on_person_id"

  create_table "countries", :force => true do |t|
    t.string   "name",       :limit => 45
    t.string   "dial_code",  :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "dialogues", :force => true do |t|
    t.integer  "rate_id",                              :null => false
    t.datetime "created_at"
    t.string   "ip_address",             :limit => 16, :null => false
    t.integer  "user_id",                              :null => false
    t.boolean  "appeal_for_arbitration"
    t.text     "suggested_comment"
    t.text     "message",                              :null => false
  end

  create_table "employments", :force => true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "organisation_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "main_email"
    t.string   "twitter",         :limit => 20
  end

  add_index "employments", ["organisation_id"], :name => "index_employments_on_organisation_id"
  add_index "employments", ["person_id"], :name => "index_employments_on_person_id"

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "internal_regulator_scores", :force => true do |t|
    t.string   "description", :limit => 45, :null => false
    t.float    "value",                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "internal_sector_types", :force => true do |t|
    t.string   "description", :limit => 45, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "internal_service_types", :force => true do |t|
    t.string   "description",       :limit => 45, :null => false
    t.boolean  "requires_type_col"
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "seo_keywords"
    t.string   "seo_single_word",   :limit => 25
  end

  create_table "organisations", :force => true do |t|
    t.string   "name",                    :limit => 120, :null => false
    t.string   "url",                     :limit => 120
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "internal_sector_type_id"
    t.string   "main_email"
    t.string   "twitter",                 :limit => 20
  end

  create_table "ownership_types", :force => true do |t|
    t.string   "description", :limit => 45, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ownerships", :force => true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.float    "share"
    t.integer  "owning_organisation_id"
    t.integer  "organisation_id"
    t.integer  "person_id"
    t.integer  "ownership_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ownerships", ["organisation_id"], :name => "index_ownerships_on_organisation_id"
  add_index "ownerships", ["owning_organisation_id"], :name => "index_ownerships_on_owning_organisation_id"
  add_index "ownerships", ["person_id"], :name => "index_ownerships_on_person_id"

  create_table "people", :force => true do |t|
    t.string   "family_name",  :limit => 45, :null => false
    t.string   "given_name",   :limit => 45
    t.string   "middle_names", :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "main_email"
    t.string   "twitter",      :limit => 20
  end

  create_table "permissions", :force => true do |t|
    t.integer  "organisation_id"
    t.integer  "service_id"
    t.integer  "user_id",                        :null => false
    t.boolean  "is_owner"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.datetime "processed"
    t.boolean  "accepted"
    t.integer  "processed_by_id"
    t.integer  "access_code"
    t.integer  "code_failures"
    t.boolean  "email_all_ratings"
    t.boolean  "notify_poor_ratings"
    t.boolean  "obsolete"
    t.boolean  "notify_good_care_guide_reviews"
  end

  create_table "person_names", :force => true do |t|
  end

  create_table "phone_types", :force => true do |t|
    t.string   "description", :limit => 45, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phones", :force => true do |t|
    t.string   "number",          :limit => 15
    t.integer  "country_id",                    :null => false
    t.integer  "phone_type_id"
    t.integer  "address_type_id",               :null => false
    t.integer  "organisation_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phones", ["organisation_id"], :name => "index_phones_on_organisation_id"
  add_index "phones", ["person_id"], :name => "index_phones_on_person_id"

  create_table "public_scores", :force => true do |t|
    t.integer  "service_id"
    t.integer  "person_id"
    t.integer  "public_scores_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "public_scores", ["person_id"], :name => "index_public_scores_on_person_id"
  add_index "public_scores", ["service_id"], :name => "index_public_scores_on_service_id"

  create_table "public_scores_status", :force => true do |t|
    t.string "description", :limit => 45
    t.text   "visible"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month"
    t.integer  "year",       :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "rater_types", :force => true do |t|
    t.string   "short_description", :limit => 35, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "long_description",  :limit => 60
  end

  create_table "rates", :force => true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.integer  "stars",                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comments"
    t.datetime "response_required_by"
    t.integer  "next_rating"
    t.integer  "original_stars"
    t.integer  "rater_type_id"
    t.integer  "status_mask"
    t.date     "effective_date"
  end

  add_index "rates", ["rateable_id"], :name => "index_rates_on_rateable_id"
  add_index "rates", ["rater_id"], :name => "index_rates_on_rater_id"

  create_table "ratings", :force => true do |t|
    t.integer  "rater_id"
    t.integer  "service_id"
    t.integer  "stars",                                                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comments"
    t.datetime "response_required_by"
    t.integer  "next_rating"
    t.integer  "rater_type_id"
    t.integer  "status_mask"
    t.date     "effective_date"
    t.string   "creation_ip_address",  :limit => 16, :default => "fill", :null => false
    t.text     "response_text"
    t.string   "response_ip_address",  :limit => 16
    t.datetime "response_datetime"
    t.integer  "response_user_id"
    t.string   "phone",                :limit => 15
    t.string   "ivr_session"
    t.string   "recording_url"
    t.string   "name_recording_url"
  end

  add_index "ratings", ["ivr_session"], :name => "index_ratings_on_ivr_session", :unique => true

  create_table "registrations", :force => true do |t|
    t.integer  "regulator_id"
    t.integer  "service_id"
    t.integer  "organisation_id"
    t.string   "regulator_given_id",        :limit => 120
    t.date     "effective_date"
    t.integer  "regulator_score_id"
    t.integer  "regulator_service_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "checksum",                  :limit => 40
  end

  add_index "registrations", ["organisation_id"], :name => "index_registrations_on_organisation_id"
  add_index "registrations", ["regulator_id"], :name => "index_registrations_on_regulator_id"
  add_index "registrations", ["service_id"], :name => "index_registrations_on_service_id"

  create_table "regulator_scores", :force => true do |t|
    t.string   "regulator_description",       :null => false
    t.integer  "internal_regulator_score_id"
    t.integer  "regulator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regulator_sector_types", :force => true do |t|
    t.string   "regulator_description",   :limit => 120, :null => false
    t.integer  "regulator_id"
    t.integer  "internal_sector_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regulator_service_types", :force => true do |t|
    t.string   "regulator_description",    :null => false
    t.integer  "internal_service_type_id"
    t.integer  "regulator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regulators", :force => true do |t|
    t.string   "domain",               :limit => 100, :null => false
    t.string   "web_page_format"
    t.integer  "organisation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "regulation_type"
    t.string   "description"
    t.string   "short_name",           :limit => 10
    t.datetime "last_scrape_start"
    t.datetime "last_scrape_finish"
    t.datetime "last_complete_scrape"
    t.string   "scraper",              :limit => 50
    t.boolean  "obsolete"
  end

  create_table "service_links", :force => true do |t|
    t.string   "url",              :null => false
    t.integer  "service_id",       :null => false
    t.integer  "user_id",          :null => false
    t.date     "publication_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_links", ["service_id"], :name => "index_service_links_on_service_id"

  create_table "service_regulator_scores", :force => true do |t|
    t.date     "effective_date",     :null => false
    t.integer  "regulator_score_id"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_regulator_scores", ["service_id"], :name => "index_service_regulator_scores_on_service_id"

  create_table "services", :force => true do |t|
    t.date     "date_started_trading",                        :null => false
    t.boolean  "date_started_trading_implied"
    t.integer  "capacity"
    t.text     "description"
    t.string   "elevator_pitch",               :limit => 150
    t.integer  "organisation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cached_rating"
    t.integer  "no_comments"
    t.integer  "invite_comment_up_to_stars"
    t.boolean  "users_need_approval"
    t.datetime "disable_rating_appeal"
    t.integer  "internal_service_type_id"
    t.datetime "deregistration_date"
    t.integer  "regulator_id"
    t.string   "regulator_given_id",           :limit => 20
    t.string   "slug"
    t.string   "good_care_guide_slug"
    t.datetime "check_good_care_guide_until"
  end

  add_index "services", ["organisation_id"], :name => "index_services_on_organisation_id"
  add_index "services", ["slug"], :name => "index_services_on_slug"

  create_table "towns", :force => true do |t|
    t.string   "name",       :limit => 60, :null => false
    t.float    "lat",                      :null => false
    t.float    "lng",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "towns", ["name"], :name => "index_towns_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "password_salt",                         :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "terms_and_conditions"
    t.datetime "reset_password_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
