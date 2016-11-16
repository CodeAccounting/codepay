Rails.application.routes.draw do

  devise_for :admins, controllers: {
                       registrations: 'admins/admins/registrations',
                       sessions: 'admins/admins/sessions',
                       passwords: 'admins/admins/passwords',
                       invitations: 'admins/admins/invitations'
                      }
  devise_for :users, controllers: {
                       registrations: 'users/registrations',
                       sessions: 'users/sessions',
                       passwords: 'users/passwords',
                       invitations: 'users/invitations'
                      }

  resources :dashboards
  resources :settings, except: [:new]
  resources :reports
  post "/reports/download_file", to: "reports#download_file", as: :report_download_file

  root to: "static_pages#root"
  get "/welcome", to: "static_pages#welcome"

  # For showing searched result
  get '/search', to: "static_pages#search", as: :search
  get '/contact_us', to: "static_pages#contact_us", as: :contact_us

  resources :beta_signups, only: [:create, :show]
  resources :contacts, only: [:index, :create]

  # resources :invoices
  # get "/invoices/copy_invoice/:id", to: "invoices#copy_invoice"
  # get "/invoices/restore_invoice/:id", to: "invoices#restore", as: :restore_invoice
  # post "/invoices/pdf_items/:id", to: "invoices#pdf_items", as: :pdf_items
  # post "/invoices/invoice_preview", to: "invoices#invoice_preview", as: :invoice_preview

  # resources :invoice_reminders #for invoice reminders
  # resources :invoice_emails, only: [:index, :show] #for invoice reminders
  # resources :customers

  resources :bills
  get "/bills/copy_bill/:id", to: "bills#copy_bill"
  post "/bills/bill_preview", to: "bills#bill_preview", as: :bill_preview
  
  
  resources :payments 
  post "payments/pay_bills" , to: "payments#pay_bills", as: :pay_bills

  
  resources :vendors #changed from "Vendors"
  get "/vendors/:id/show_attachments", to: "vendors#show_attachments", as: :show_attachments

  resources :organizations
  resources :organization_users
  post "/change_role", to: "organization_users#update"

  resources :emails, only: [:new, :create]
  post "/invoice_emails_data", to: "emails#update"
  post "/emails/send_mail", to: "emails#send_mail"

  resources :classifications, only: [:create]


  resources :users, only: [:show, :edit, :update]
  get "/users/:organization_id/change_organization", to: "users#change_organization", as: :change_organization
  # get "/users/:organization_id/change_user_organization", to: "users#change_user_organization", as: :change_user_organization
  get "/users/:id/edit_profile", to: "settings#edit_profile", as: :edit_profile
  get "/users/:id/edit_payment_account", to: "settings#edit_payment_account", as: :edit_payment_account
  get "/users/:id/edit_software_integration", to: "settings#edit_software_integration", as: :edit_software_integration
  get "/users/:organization_id/change_admin_organization", to: "users#change_admin_organization", as: :change_admin_organization
  
  resources :bank_accounts
  resources :bill_informations

  # resources :invoice_payments
  # post "/invoice_payments/on_change", to: "invoice_payments#on_change"               

  resources :audits
  resources :bill_approvals

  resources :attachments, except: [:new]
  post "attachments/delete_files", to: "attachments#delete_files", as: :attachment_delete_files
  post "attachments/attachment_via_ajax", to: "attachments#attachment_via_ajax", as: :attachment_via_ajax

  resources :subscriptions 
  post "/subscriptions/webhooks", to:"subscriptions#webhooks"
  post "/subscriptions/cancel_subscription", to:"subscriptions#cancel_subscription", as: :cancel_subscription
  post "/subscriptions/upgrade_trial_subscription", to:"subscriptions#upgrade_trial_subscription", as: :upgrade_trial_subscription
  post "/subscriptions/upgrade_active_subscription", to: "subscriptions#upgrade_active_subscription", as: :upgrade_active_subscription
  #   collection do
  #     post 'webhooks'
  #   end
  # end

  resources :charges
  resources :items
  get "/items/:id/remove_item", to: "items#remove_item", as: :remove_item

  resources :taxs
  resources :approvals
  resources :chart_of_accounts
  resources :basic
  resources :support

  # resources :notes
  get "/notes/ajax_to_add_note", to: "notes#ajax_to_add_note", as: :ajax_to_add_note
  get "/notes/notes_list_by_ajax", to: "notes#notes_list_by_ajax", as: :notes_list_by_ajax
  
  get "/admins" => redirect("/admins/dashboards")

  namespace "admins" do
    resources :dashboards
    get '/search', to: "dashboards#search", as: :search

    resources :organizations
    resources :organization_users
    resources :invoices
    resources :customers
    resources :reports
    post "/reports/download_file", to: "reports#download_file", as: :report_download_file

    resources :bill_pay_requests, only: [:index, :show]
    match "/bill_pay_requests/:id/payment", to: "bill_pay_requests#payment", as: :create_bill_payment, via: [:get,:post]
    # get "organization_users/csv_download", to: "organization_users#csv_download"

    resources :users
    resources :audits
  end  
  
end
