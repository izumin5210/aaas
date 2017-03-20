Rails.application.routes.draw do
  root to: 'dashboard#show'

  devise_for :accounts, controllers: {
    registrations: 'accounts/registrations',
  }
  use_doorkeeper

  get '/auth/:provider/callback', to: 'oauth_accounts/sessions#create'
end
