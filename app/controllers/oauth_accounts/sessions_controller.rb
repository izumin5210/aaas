class OauthAccounts::SessionsController < ApplicationController
  def create
    cmd = FindOrCreateOauthAccountCommand.run(
      auth_hash: request.env['omniauth.auth'],
      user: current_account&.user,
    )

    sign_in(:account, cmd.account) if cmd.success?

    redirect_to root_path
  end
end
