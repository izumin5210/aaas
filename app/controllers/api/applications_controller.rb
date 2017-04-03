class Api::ApplicationsController < Api::BaseController
  include Garage::RestfulActions

  private

  def require_resource
    @resource = OauthApplication.find(params[:id])
  end

  def require_resources
    @resources = current_resource_owner.oauth_applications
    protect_resource_as OauthApplicationRepresenter
  end

  def create_resource
    @resource = @resources.new
    @resource.owner = current_resource_owner
    @resource.update_attributes!(app_params)
    @resource
  end

  def update_resource
    @resource.update_attributes!(app_params)
    @resource
  end

  def destroy_resource
    @resource.destroy
    @resource
  end

  def app_params
    params.permit(:name, :redirect_uri, :scopes)
  end
end
