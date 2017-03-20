class Oauth::ApplicationsController < Doorkeeper::ApplicationsController
  before_filter :authenticate_account!

  def index
    @applications = current_account.user.oauth_applications
  end

  def create
    @application = Doorkeeper::Application.new(application_params)
    @application.owner = current_account.user
    if @application.save
      flash[:notice] = I18n.t(:notice, :scope => [:doorkeeper, :flash, :applications, :create])
      redirect_to oauth_application_url(@application)
    else
      render :new
    end
  end

  private

  def set_application
    @application = current_account.user.oauth_applications.find(params[:id])
  end
end
