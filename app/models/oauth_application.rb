class OauthApplication < Doorkeeper::Application
  include Garage::Representer
  include Garage::Authorizable

  property :name
  property :uid
  property :secret
  property :redirect_uri
  collection :scopes

  def build_permissions(perms, other)
    params.permit! :read, :write
  end

  def self.build_permissions(perms, other, target)
    params.permit! :read, :write
  end
end
