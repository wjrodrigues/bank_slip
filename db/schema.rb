# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_24_190425) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "bankslips", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "status", default: "opened", null: false
    t.datetime "expire_at", null: false
    t.integer "amount", null: false
    t.string "gateway", null: false
    t.uuid "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_bankslips_on_customer_id"
    t.check_constraint "gateway::text = 'kobana'::text"
    t.check_constraint "status::text = ANY (ARRAY['opened'::text, 'overdue'::text, 'canceled'::text, 'expired'::text])"
  end

  create_table "customers", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "document", limit: 14, null: false
    t.string "state", limit: 100, null: false
    t.string "city", limit: 100, null: false
    t.string "zipcode", limit: 12, null: false
    t.string "address", limit: 250, null: false
    t.string "neighborhood", limit: 100, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document", "deleted_at"], name: "index_customers_on_document_and_deleted_at", unique: true
  end

end
