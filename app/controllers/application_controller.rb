class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :update_allowed_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def increment_counter
    @counter = session[:counter] = (session[:counter] || 0) + 1
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |user| user.permit(:name, :surname, :email, :password)}
    devise_parameter_sanitizer.permit(:account_update) { |user| user.permit(:name, :surname, :email, :password, :current_password)}
  end
end
