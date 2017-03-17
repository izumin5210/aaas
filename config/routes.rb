Rails.application.routes.draw do
  root to: 'dashboard#show'

  devise_for :accounts
  use_doorkeeper
end
