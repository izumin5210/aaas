Rails.application.routes.draw do
  devise_for :accounts
  use_doorkeeper
end
