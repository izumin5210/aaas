Garage.configuration.strategy = Garage::Strategy::Doorkeeper

Garage.configure {}

Garage::TokenScope.configure do
  namespace :user do
    register :read, desc: 'accessing publicly available data' do
      access :read, OauthApplication
    end

    register :write, desc: 'reading and writing data' do
      access :write, OauthApplication
    end
  end
end
