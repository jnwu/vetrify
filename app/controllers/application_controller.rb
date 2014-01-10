class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # force_ssl

protected

  def current_user
    if session[:user_type] && session[:user_type] == "business_user"
      @current_user ||= BusinessUser.find(session[:user_id])
    elsif session[:user_type] && session[:user_type] == "applicant"
      @current_user ||= Profile.find(session[:user_id])
    end
  end

  helper_method :current_user
end
