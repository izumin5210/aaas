class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  helper_method :current_user

  def current_user
    current_account&.user
  end
end
