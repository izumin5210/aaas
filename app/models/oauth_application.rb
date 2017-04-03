class OauthApplication < Doorkeeper::Application
  def to_resource
    OauthApplicationRepresenter.new(self)
  end
end
