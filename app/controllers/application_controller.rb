class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

end
