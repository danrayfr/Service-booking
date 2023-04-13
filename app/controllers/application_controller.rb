class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_render_cart
  before_action :initialize_cart
  
  private 
  
  def set_render_cart
    @render_cart = true
  end

  def initialize_cart
    if user_signed_in? # Assuming you are using Devise or a similar authentication gem
      @cart ||= current_user.cart || Cart.create(user: current_user) # Associate cart with the logged-in user
    else
      @cart ||= Cart.find_by(id: session[:cart_id]) # Fallback to session-based cart for guests
    end
  
    if @cart.nil?
      @cart = Cart.create
      session[:cart_id] = @cart.id unless user_signed_in? # Store cart_id in session only for guests
    end
  end

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
