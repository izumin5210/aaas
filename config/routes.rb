Rails.application.routes.draw do

  root to: 'dashboard#index'

  devise_for :accounts, controllers: {
    registrations: 'accounts/registrations',
  }

  use_doorkeeper do
    controllers applications: 'oauth/applications'
  end

  get '/auth/:provider/callback', to: 'oauth_accounts/sessions#create'
end
