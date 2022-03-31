class ApplicationController < ActionController::Base
  def increment_counter
    @counter = session[:counter] = (session[:counter] || 0) + 1
  end
end
