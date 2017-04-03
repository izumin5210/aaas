Doorkeeper::Application.seed do |s|
  s.id           = 1
  s.name         = 'aaas'
  s.uid          = Doorkeeper::OAuth::Helpers::UniqueToken.generate
  s.secret       = Doorkeeper::OAuth::Helpers::UniqueToken.generate
  s.redirect_uri = 'urn:ietf:wg:oauth:2.0:oob'
  s.scopes       = Garage::TokenScope.all_scopes.map(&:to_s).join(' ')
  s.owner        = Organization.admin
end
