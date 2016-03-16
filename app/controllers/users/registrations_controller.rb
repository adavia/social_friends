class Users::RegistrationsController < Devise::RegistrationsController
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
  end
end
