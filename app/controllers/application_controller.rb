class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    #devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :document, :name, :lastname, :phone, :role, :password, :password_confirmation, :avatar, :avatar_cache) }
    #devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :name, :lastname, :phone, :password, :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar) }
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:email, :document, :name, :lastname, :phone, :role, :password, :password_confirmation, :avatar, :avatar_cache)
    end
    
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:email, :name, :lastname, :phone, :password, :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar)
    end
  end

end
