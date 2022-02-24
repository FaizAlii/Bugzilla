# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    # rubocop:disable Rails/LexicallyScopedActionFilter
    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, only: [:update]
    # rubocop:enable Rails/LexicallyScopedActionFilter

    protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      # devise_parameter_sanitizer.permit(:name, :email, :password, :password_confirmation)
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

    def set_role
      @user.roles = []
      return unless params.key?(:users_roles)

      params[:users_roles][:role_ids].each do |role|
        @user.add_role(Role.find(role).name)
      end
    end
  end
end
