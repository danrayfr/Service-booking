class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :mobile, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :mobile, :role])
  end

  # Confirms an admin user
  def admin_user
    redirect_to root_url, notice: "You're not authorized to access this page." unless current_user.admin?
  end
  
end
