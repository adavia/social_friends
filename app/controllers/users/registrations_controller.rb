class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :js, :html
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Override Devise default behaviour and create a profile as well
  def new
    build_resource({})
    resource.build_profile
    respond_with self.resource
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |user|
      user.permit(:username, :email, :password, :password_confirmation, 
        profile_attributes: [:birthday, :gender, :location])
    end
    devise_parameter_sanitizer.for(:account_update) do |user| 
      user.permit(:password, :password_confirmation, :current_password) 
    end
  end

  def after_update_path_for(resource)
    [resource, resource.profile]
  end
end
