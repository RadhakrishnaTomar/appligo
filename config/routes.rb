# frozen_string_literal: true

Rails.application.routes.draw do
  # devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :team_members, controllers: { registrations: 'team_members/registrations' }
  # devise_for :companies
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root 'home#index'
  resources :departments do
    resources :desingations
  end
  resources :companies do
    resources :permissions, only: %w[index] do
      collection do
        post 'permissions_setter'
      end
    end
  end

  resources :applicants do
    collection do
      get "applicant_profile_data"
    end
    resources :interviews
  end
  resources :team_members
  resources :comments
  resources :profiles
  resources :roles
  resources :subscriptions
  resources :organisation_settings,only:[:index,:new,:edit]
  
  get '/team_members/:id/interviews' => 'interviews#interview_feedback', as: "interview_feedback"

  put 'team_members/:id/feedback_update' => 'interviews#feedback_update', as: 'feedback_update'

  get '/team_members/:id/assigned_interviews' => 'interviews#assigned_interviews', as: 'assigned_interviews'
  get '/interviews/data' =>'interviews#data'
  get '/interviews/show_data' =>'interviews#show_data'
  post '/team_members_create' => 'team_members#create_member', as: 'create_team_member'
  delete '/team_members/:id' => 'team_members#destroy', as: 'delete_member'

  resources :bulk_uploads, only: %w[index new create]

  get '/team_details/' => 'team_members#team_details', as: 'team_details'

  get '/applicant_upload_bulk/new' => 'applicants#new_bulk_upload', as: 'bulk_upload_applicant'
  post '/applicant_upload_bulk/new' => 'bulk_uploads#create'
  post '/applicant_upload_bulk/data' => 'applicants#applicant_data_mapping', as: 'bulk_upload_data'
  post '/applicant_upload_bulk/rejected' => 'applicants#send_csv'
  get  "/saml/init" => "saml#init"
  post "/saml/consume" => "saml#consume"
  post "/saml/create_sso_organization" => "saml#create_sso_organization"
  post "/saml/create_user" => "saml#create_user"
  get  "sign-in" => "saml#sign", as: :saml_sign
  delete  "saml/logout" => "saml#logout"
  post '/create_organisation' =>'organisation_settings#create_organisation'
  get '/home/graph_show' => 'home#graph_show'
end
