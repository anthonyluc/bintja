# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_09_162930) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "blazer_audits", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "query_id"
    t.text "statement"
    t.string "data_source"
    t.datetime "created_at"
    t.index ["query_id"], name: "index_blazer_audits_on_query_id"
    t.index ["user_id"], name: "index_blazer_audits_on_user_id"
  end

  create_table "blazer_checks", force: :cascade do |t|
    t.bigint "creator_id"
    t.bigint "query_id"
    t.string "state"
    t.string "schedule"
    t.text "emails"
    t.text "slack_channels"
    t.string "check_type"
    t.text "message"
    t.datetime "last_run_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_blazer_checks_on_creator_id"
    t.index ["query_id"], name: "index_blazer_checks_on_query_id"
  end

  create_table "blazer_dashboard_queries", force: :cascade do |t|
    t.bigint "dashboard_id"
    t.bigint "query_id"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dashboard_id"], name: "index_blazer_dashboard_queries_on_dashboard_id"
    t.index ["query_id"], name: "index_blazer_dashboard_queries_on_query_id"
  end

  create_table "blazer_dashboards", force: :cascade do |t|
    t.bigint "creator_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_blazer_dashboards_on_creator_id"
  end

  create_table "blazer_queries", force: :cascade do |t|
    t.bigint "creator_id"
    t.string "name"
    t.text "description"
    t.text "statement"
    t.string "data_source"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_blazer_queries_on_creator_id"
  end

  create_table "followers", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_followers_on_followed_id"
    t.index ["follower_id"], name: "index_followers_on_follower_id"
  end

  create_table "ingredient_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.integer "calorie"
    t.integer "ingredient_category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ingredient_category_id"], name: "index_ingredients_on_ingredient_category_id"
  end

  create_table "quantities", force: :cascade do |t|
    t.integer "quantity"
    t.string "unity"
    t.boolean "add_shopping_list", default: false
    t.bigint "ingredient_id", null: false
    t.bigint "recipe_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["add_shopping_list"], name: "index_quantities_on_add_shopping_list"
    t.index ["ingredient_id"], name: "index_quantities_on_ingredient_id"
    t.index ["recipe_id"], name: "index_quantities_on_recipe_id"
  end

  create_table "recipe_groups", force: :cascade do |t|
    t.string "name"
    t.boolean "private", default: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_recipe_groups_on_user_id"
  end

  create_table "recipe_rates", force: :cascade do |t|
    t.integer "stars", default: 0, null: false
    t.string "video_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stars"], name: "index_recipe_rates_on_stars"
    t.index ["user_id"], name: "index_recipe_rates_on_user_id"
    t.index ["video_id"], name: "index_recipe_rates_on_video_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.string "url_video"
    t.string "url_image"
    t.integer "preparation_time", default: 0, null: false
    t.integer "cooking_time", default: 0, null: false
    t.boolean "favorite", default: false
    t.text "note"
    t.boolean "note_private", default: false
    t.boolean "official", default: false
    t.integer "alert"
    t.boolean "show", default: true
    t.bigint "user_id", null: false
    t.integer "recipe_group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["favorite"], name: "index_recipes_on_favorite"
    t.index ["official"], name: "index_recipes_on_official"
    t.index ["recipe_group_id"], name: "index_recipes_on_recipe_group_id"
    t.index ["show"], name: "index_recipes_on_show"
    t.index ["url_video"], name: "index_recipes_on_url_video"
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "comment"
    t.string "video_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_reviews_on_user_id"
    t.index ["video_id"], name: "index_reviews_on_video_id"
  end

  create_table "shopping_lists", force: :cascade do |t|
    t.text "shopping_note"
    t.boolean "receive_email", default: true
    t.string "receive_email_day"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["receive_email"], name: "index_shopping_lists_on_receive_email"
    t.index ["receive_email_day"], name: "index_shopping_lists_on_receive_email_day"
    t.index ["user_id"], name: "index_shopping_lists_on_user_id"
  end

  create_table "social_networks", force: :cascade do |t|
    t.string "url_youtube"
    t.string "url_instagram"
    t.string "url_facebook"
    t.string "url_website"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_social_networks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nickname"
    t.text "description"
    t.string "avatar"
    t.boolean "admin", default: false, null: false
    t.integer "admin_level"
    t.boolean "blocked", default: false
    t.datetime "blocked_since"
    t.index ["admin"], name: "index_users_on_admin"
    t.index ["blocked"], name: "index_users_on_blocked"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "quantities", "ingredients"
  add_foreign_key "quantities", "recipes"
  add_foreign_key "recipe_groups", "users"
  add_foreign_key "recipe_rates", "users"
  add_foreign_key "recipes", "users"
  add_foreign_key "reviews", "users"
  add_foreign_key "shopping_lists", "users"
  add_foreign_key "social_networks", "users"
end
