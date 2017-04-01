Rails.application.routes.draw do

  root                                       to: 'dashboard#index'
  post   '/organizations',                   to: 'organizations#create', as: :organizations
  get    '/organizations/new',               to: 'organizations#new', as: :new_organization
  delete '/organizations/@:login_name',      to: 'organizations#destroy'
  patch  '/organizations/@:login_name',      to: 'organizations#update'
  get    '/organizations/@:login_name',      to: 'organizations#show', as: :organization
  get    '/organizations/@:login_name/edit', to: 'organizations#edit', as: :edit_organization

  devise_for :accounts, controllers: {
    registrations: 'accounts/registrations',
  }

  use_doorkeeper do
    controllers applications: 'oauth/applications'
  end

  namespace :api do
    get    '/applications',     to: 'applications#index'
    post   '/applications',     to: 'applications#create'
    delete '/applications/:id', to: 'applications#destroy'
    get    '/applications/:id', to: 'applications#show'
    patch  '/applications/:id', to: 'applications#update'
  end

  get '/auth/:provider/callback', to: 'oauth_accounts/sessions#create'
end
