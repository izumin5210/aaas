Garage.configure {}

Garage::TokenScope.configure do
  register :public, desc: 'accessing publicly available data' do
  end

  namespace :user do
    register :read, desc: 'accessing user\'s data' do
      access :read, OauthApplication
    end

    register :write, desc: 'creating and updating user\'s data' do
    end
  end
end

Garage.configuration.strategy = Garage::Strategy::Doorkeeper

Doorkeeper.configure do
  default_scopes  :public
  optional_scopes *Garage::TokenScope.optional_scopes
end
