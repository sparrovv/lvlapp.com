# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :native_language
  end
end
