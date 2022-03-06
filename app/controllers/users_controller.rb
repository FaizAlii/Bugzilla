# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_params

  def index
    return unless params[:search] && params[:search] != ''

    @users = @users.where('users.name like ? OR email LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
  end

  private

  def set_params
    @user_type = params[:user_type]
    @users = User.where.not(id: current_user.id).with_role @user_type
    @project_id = params[:project_id]
  end
end
