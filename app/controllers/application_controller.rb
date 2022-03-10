# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :authenticate_user!
  before_action :configure_sign_up_params, only: :create, if: :devise_controller?
  before_action :configure_account_update_params, only: :update, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    projects_path
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, { role_ids: [] }])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, { role_ids: [] }])
  end

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end

  def record_not_found
    flash[:alert] = 'Record not Found!.'
    redirect_to(request.referer || root_path)
    # render plain: "404 Not Found", status: 404
  end
end
