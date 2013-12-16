class ApplicationController < ActionController::Base
  has_mobile_fu false # that's how I get helper methods like: is_mobile_device? || is_tablet_device?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :store_location

  helper_method :render_ga?
  helper_method :os_not_supported?

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    if (request.get? &&
        !request.xhr? &&
        request.fullpath != "/users/sign_in" &&
        request.fullpath != "/users/sign_up" &&
        request.fullpath != "/users/password")
      # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def render_ga?
    Rails.env == 'production'
  end

  def os_not_supported?
    is_mobile_device? || is_tablet_device?
  end
end
