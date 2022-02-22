# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :configure_sign_up_params, only: :create, if: :devise_controller?
  after_action :set_role, only: %i[create update], if: :devise_controller?
  before_action :configure_account_update_params, only: :update, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    users_path
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def set_role
    @user.roles = []
    params[:users_roles][:role_ids].each do |role|
      @user.add_role(Role.find(role).name)
    end
  end
end
