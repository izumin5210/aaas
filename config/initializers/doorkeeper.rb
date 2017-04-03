Doorkeeper.configure do
  orm :active_record

  resource_owner_authenticator do
    (current_account || warden.authenticate!(scope: :account))&.user
  end

  enable_application_owner confirmation: true

  skip_authorization do |resource_owner, client|
    client.owner&.admin? || false
  end
end
