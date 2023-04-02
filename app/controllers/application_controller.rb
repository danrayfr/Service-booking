class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :mobile, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :mobile, :role])
  end

  # Confirms if user is logged in
  def logged_in_user
    unless user_signed_in?
      redirect_to new_user_session_url, notice: "Please login."
    end
  end

  # Confirms an admin user
  def admin_user
    unless current_user.admin?
      redirect_to root_url, notice: "You're not authorized."
    end
  end  
  
end
