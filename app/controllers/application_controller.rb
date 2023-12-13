class ApplicationController < ActionController::Base
  check_authorization unless: :devise_controller?
  authorize_resource unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
end
