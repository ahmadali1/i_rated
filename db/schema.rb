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

ActiveRecord::Schema.define(version: 20160801061528) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "actors", force: :cascade do |t|
    t.string   "name",          limit: 60,  null: false
    t.integer  "age",           limit: 4
    t.string   "country",       limit: 20
    t.string   "gender",        limit: 255
    t.date     "date_of_birth"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "biography",     limit: 65535
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "favourite_movies", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "movie_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "favourite_movies", ["movie_id"], name: "index_favourite_movies_on_movie_id", using: :btree
  add_index "favourite_movies", ["user_id"], name: "index_favourite_movies_on_user_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.integer  "imageable_id",       limit: 4,   null: false
    t.string   "imageable_type",     limit: 255, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  add_index "images", ["imageable_id", "imageable_type"], name: "index_images_on_imageable_id_and_imageable_type", using: :btree

  create_table "movie_casts", force: :cascade do |t|
    t.integer  "movie_id",   limit: 4, null: false
    t.integer  "actor_id",   limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "movie_casts", ["actor_id"], name: "index_movie_casts_on_actor_id", using: :btree
  add_index "movie_casts", ["movie_id"], name: "index_movie_casts_on_movie_id", using: :btree

  create_table "movies", force: :cascade do |t|
    t.string   "name",           limit: 60,                    null: false
    t.date     "released_date",                                null: false
    t.boolean  "is_featured",                  default: false, null: false
    t.text     "description",    limit: 65535
    t.string   "duration",       limit: 20
    t.string   "embedded_video", limit: 250
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "genre",          limit: 30
    t.boolean  "delta",                        default: true,  null: false
    t.boolean  "approved",                     default: false
  end

  add_index "movies", ["genre"], name: "index_movies_on_genre", using: :btree
  add_index "movies", ["is_featured"], name: "index_movies_on_is_featured", using: :btree
  add_index "movies", ["name"], name: "index_movies_on_name", using: :btree
  add_index "movies", ["released_date"], name: "index_movies_on_released_date", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "score",      limit: 4, default: 0, null: false
    t.integer  "user_id",    limit: 4
    t.integer  "movie_id",   limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "ratings", ["movie_id"], name: "index_ratings_on_movie_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "report_reviews", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "review_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "report_reviews", ["review_id"], name: "index_report_reviews_on_review_id", using: :btree
  add_index "report_reviews", ["user_id"], name: "index_report_reviews_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "movie_id",     limit: 4
    t.integer  "user_id",      limit: 4
    t.text     "comment",      limit: 65535,             null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "report_count", limit: 4,     default: 0
  end

  add_index "reviews", ["movie_id"], name: "index_reviews_on_movie_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "first_name",             limit: 60,               null: false
    t.string   "last_name",              limit: 60,               null: false
    t.string   "gender",                 limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "unconfirmed_email",      limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["first_name"], name: "index_users_on_first_name", using: :btree
  add_index "users", ["last_name"], name: "index_users_on_last_name", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "favourite_movies", "movies"
  add_foreign_key "favourite_movies", "users"
  add_foreign_key "movie_casts", "actors"
  add_foreign_key "movie_casts", "movies"
  add_foreign_key "ratings", "movies"
  add_foreign_key "ratings", "users"
  add_foreign_key "report_reviews", "reviews"
  add_foreign_key "report_reviews", "users"
  add_foreign_key "reviews", "movies"
  add_foreign_key "reviews", "users"
end
