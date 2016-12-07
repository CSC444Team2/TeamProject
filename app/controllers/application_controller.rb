class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  def current_user
  @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
  def google_api_key
    @google_api_key="AIzaSyAPPjwMFya1WWPKvvxq5UX-bLnxi-6wVuE"
  end
end


