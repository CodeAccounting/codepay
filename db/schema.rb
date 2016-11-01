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

ActiveRecord::Schema.define(version: 20161025072849) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "tax_id",                           null: false
    t.boolean  "is_vendor_1099",   default: false, null: false
    t.string   "account_number",                   null: false
    t.date     "vendor_since"
    t.integer  "lead_time",        default: 0,     null: false
    t.string   "payment_terms"
    t.boolean  "combine_payments", default: false, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "accounts", ["account_number"], name: "index_accounts_on_account_number", unique: true, using: :btree
  add_index "accounts", ["tax_id"], name: "index_accounts_on_tax_id", unique: true, using: :btree

  create_table "addresses", force: :cascade do |t|
    t.string   "address1",                  null: false
    t.string   "address2"
    t.string   "city",                      null: false
    t.string   "state",                     null: false
    t.string   "zip",                       null: false
    t.string   "country",    default: "US", null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "role"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "approvals", force: :cascade do |t|
    t.integer  "approvable_id"
    t.integer  "assigned_by"
    t.integer  "assigned_to"
    t.string   "approvable_type"
    t.string   "status",          default: "Pending"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "approvals", ["approvable_id"], name: "index_approvals_on_approvable_id", using: :btree
  add_index "approvals", ["assigned_by"], name: "index_approvals_on_assigned_by", using: :btree
  add_index "approvals", ["assigned_to"], name: "index_approvals_on_assigned_to", using: :btree

  create_table "attachments", force: :cascade do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "referenceable_id"
    t.string   "referenceable_type"
  end

  add_index "attachments", ["referenceable_id"], name: "index_attachments_on_referenceable_id", using: :btree
  add_index "attachments", ["referenceable_type"], name: "index_attachments_on_referenceable_type", using: :btree

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index", using: :btree
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
  add_index "audits", ["created_at"], name: "index_audits_on_created_at", using: :btree
  add_index "audits", ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
  add_index "audits", ["user_id", "user_type"], name: "user_index", using: :btree

  create_table "background_images", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "organization_id"
    t.integer  "account_number"
    t.string   "bank_name"
    t.string   "payable",         default: "Yes"
    t.string   "default",         default: "Yes"
    t.string   "receivable"
    t.string   "status",          default: "Varified"
    t.string   "active",          default: "Active"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "bank_accounts", ["creator_id", "organization_id"], name: "index_bank_accounts_on_creator_id_and_organization_id", using: :btree

  create_table "beta_signups", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bill_approvals", force: :cascade do |t|
    t.integer  "bill_id"
    t.integer  "assigned_by"
    t.integer  "assigned_to"
    t.string   "status",      default: "Pending"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "bill_approvals", ["assigned_by"], name: "index_bill_approvals_on_assigned_by", using: :btree
  add_index "bill_approvals", ["assigned_to"], name: "index_bill_approvals_on_assigned_to", using: :btree
  add_index "bill_approvals", ["bill_id"], name: "index_bill_approvals_on_bill_id", using: :btree

  create_table "bill_informations", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "bill_id"
    t.integer  "transaction_number"
    t.string   "payment_type"
    t.datetime "processing_date"
    t.datetime "deposit_date"
    t.datetime "arrival_date"
    t.datetime "due_date"
    t.integer  "account_used"
    t.string   "vendor_name"
    t.integer  "vendor_account"
    t.text     "memo"
    t.text     "description"
    t.integer  "check_number"
    t.integer  "authorizer_id"
    t.datetime "authorization_date"
    t.datetime "approver_id"
    t.datetime "approval_date"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "bill_items", force: :cascade do |t|
    t.integer  "bill_id"
    t.integer  "item_id"
    t.string   "description"
    t.integer  "quantity"
    t.decimal  "price",       precision: 8, scale: 2
    t.integer  "location_id"
    t.decimal  "amount",      precision: 8, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "tax_id"
  end

  create_table "bills", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "organization_id"
    t.integer  "vendor_id"
    t.string   "bill_number"
    t.datetime "bill_date"
    t.datetime "due_date"
    t.decimal  "due_amount",       precision: 8, scale: 2
    t.integer  "bill_template_id"
    t.integer  "payment_term_id"
    t.integer  "location_id"
    t.integer  "department_id"
    t.string   "po_number"
    t.string   "sales_rep"
    t.text     "message"
    t.boolean  "paid",                                     default: false
    t.datetime "deleted_at"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  create_table "chart_of_accounts", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "organization_id"
    t.string   "name"
    t.string   "number"
    t.string   "chart_of_account_type"
    t.string   "description"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name",         null: false
    t.string   "last_name",          null: false
    t.string   "email",              null: false
    t.string   "payment_info_email"
    t.string   "payment_info_phone"
    t.string   "phone"
    t.string   "fax"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "organization_id"
  end

  add_index "contacts", ["email"], name: "index_contacts_on_email", unique: true, using: :btree
  add_index "contacts", ["last_name"], name: "index_contacts_on_last_name", using: :btree
  add_index "contacts", ["organization_id"], name: "index_contacts_on_organization_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "company_name"
    t.integer  "parent_customer_id"
    t.string   "customer_type"
    t.integer  "contact_id"
    t.string   "account_number"
    t.string   "payment_terms"
    t.string   "description"
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
    t.integer  "organization_id"
    t.integer  "primary_contact_id"
    t.integer  "creator_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "customers", ["account_number"], name: "index_customers_on_account_number", using: :btree
  add_index "customers", ["name"], name: "index_customers_on_name", using: :btree

  create_table "dashboards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.integer "creator_id"
    t.string  "name"
  end

  create_table "identifications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "doc_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "invoice_emails", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "invoice_id"
    t.string   "to_email"
    t.string   "from_email"
    t.string   "subject"
    t.text     "raw_content"
    t.string   "status"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "message_id"
    t.string   "cc"
    t.string   "bcc"
    t.string   "sg_message_id"
  end

  create_table "invoice_items", force: :cascade do |t|
    t.integer  "invoice_id"
    t.string   "description"
    t.integer  "quantity"
    t.decimal  "price",               precision: 8, scale: 2
    t.integer  "location_id"
    t.decimal  "amount",              precision: 8, scale: 2
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "item_id"
    t.integer  "tax_id"
    t.integer  "chart_of_account_id"
  end

  add_index "invoice_items", ["invoice_id"], name: "index_invoice_items_on_invoice_id", using: :btree

  create_table "invoice_payments", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "organization_id"
    t.datetime "date"
    t.string   "payment_method"
    t.string   "payment_account"
    t.string   "reference"
    t.text     "message"
    t.decimal  "payment_amount",  precision: 8, scale: 2
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "invoice_payments_invoices", force: :cascade do |t|
    t.integer "invoice_payment_id"
    t.integer "invoice_id"
  end

  add_index "invoice_payments_invoices", ["invoice_id"], name: "index_invoice_payments_invoices_on_invoice_id", using: :btree
  add_index "invoice_payments_invoices", ["invoice_payment_id"], name: "index_invoice_payments_invoices_on_invoice_payment_id", using: :btree

  create_table "invoice_reminders", force: :cascade do |t|
    t.integer  "invoice_id", null: false
    t.datetime "sent_at",    null: false
    t.integer  "sender_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "sent_to"
  end

  add_index "invoice_reminders", ["invoice_id"], name: "index_invoice_reminders_on_invoice_id", using: :btree
  add_index "invoice_reminders", ["sender_id"], name: "index_invoice_reminders_on_sender_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.integer  "creator_id",                                                  null: false
    t.integer  "customer_id",                                                 null: false
    t.string   "invoice_number",                                              null: false
    t.datetime "invoice_date",                                                null: false
    t.datetime "due_date",                                                    null: false
    t.decimal  "due_amount",          precision: 8, scale: 2
    t.integer  "invoice_template_id"
    t.integer  "payment_term_id"
    t.integer  "location_id"
    t.integer  "department_id"
    t.string   "po_number"
    t.string   "sales_rep"
    t.text     "message"
    t.datetime "deleted_at"
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.integer  "organization_id"
    t.boolean  "received",                                    default: false
  end

  add_index "invoices", ["creator_id"], name: "index_invoices_on_creator_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "organization_id"
    t.string   "name"
    t.string   "item_of"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "locations", force: :cascade do |t|
    t.integer "creator_id"
    t.string  "name"
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "organization_id"
    t.integer  "noteable_id"
    t.string   "noteable_type"
    t.text     "body"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "organization_users", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name",                null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "organization_type"
    t.string   "accounting_software"
  end

  create_table "payments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profile_images", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "relations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.string   "user_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "reports", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "roles_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "settings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "subscription_id"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.string   "plan_id"
    t.string   "plan_name"
    t.string   "status",          default: "inactive"
    t.boolean  "continue",        default: true
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "taxes", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "organization_id"
    t.decimal  "tax",             precision: 5, scale: 2
    t.string   "tax_of"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "terms", force: :cascade do |t|
    t.integer "creator_id"
    t.string  "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                         default: "",    null: false
    t.string   "first_name",                                    null: false
    t.string   "last_name",                                     null: false
    t.string   "encrypted_password",            default: "",    null: false
    t.string   "title"
    t.datetime "date_of_birth"
    t.integer  "address_id"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                 default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
    t.integer  "current_organization_id"
    t.integer  "invited_for_id"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "stripe_customer_id"
    t.boolean  "is_master",                     default: false
    t.integer  "current_admin_organization_id"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vendors", force: :cascade do |t|
    t.string   "name"
    t.integer  "creator_id"
    t.integer  "parent_vendor_id"
    t.string   "company_name"
    t.string   "vendor_type"
    t.integer  "contact_id"
    t.string   "account_number"
    t.string   "payment_terms"
    t.string   "description"
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
    t.integer  "organization_id"
    t.integer  "primary_contact_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_foreign_key "invoice_payments_invoices", "invoice_payments"
  add_foreign_key "invoice_payments_invoices", "invoices"
end
