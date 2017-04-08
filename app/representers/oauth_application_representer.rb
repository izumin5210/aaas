class OauthApplicationRepresenter < ApplicationRepresenter
  include Garage::Authorizable

  property :name
  property :uid
  property :secret
  property :redirect_uri, as: :redirectUri
  collection :scopes

  delegate :id, :name, :uid, :secret, :redirect_uri, :scopes, to: :model

  def build_permissions(perms, other)
    perms.permits! :read
  end

  def self.build_permissions(perms, other, target)
    perms.permits! :read
  end
end
