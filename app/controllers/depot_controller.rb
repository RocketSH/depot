class DepotController < ApplicationController
  before_action :update_allowed_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def increment_counter
    @counter = session[:counter] = (session[:counter] || 0) + 1
  end

  def cors_preflight_check
    return unless request.method == 'options'
    cors_set_access_controll_headers
    render plain: ''
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |user| user.permit(:name, :surname, :email, :password)}
    devise_parameter_sanitizer.permit(:account_update) { |user| user.permit(:name, :surname, :email, :password, :current_password)}
  end

  private

  def cors_set_access_control_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, Auth-Token, Email, X-User-Token, X-User-Email, x-xsrf-token'
    response.headers['Access-Control-Max-Age'] = '1728000'
    response.headers['Access-Control-Allow-Credentials'] = true
  end
end
