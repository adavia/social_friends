class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
    # Config devise settings
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u| 
        u.permit(:username, :email, :password, :password_confirmation, :remember_me)
      end

      devise_parameter_sanitizer.for(:sign_in) do |u| 
        u.permit(:login, :username, :email, :password, :remember_me)
      end

      devise_parameter_sanitizer.for(:account_update) do |u| 
        u.permit(:username, :email, :password, :password_confirmation, :current_password)
      end
    end

    def after_sign_in_path_for(resource)
      posts_path
    end

    def after_sign_out_path_for(resource_or_scope)
      root_path
    end
end
