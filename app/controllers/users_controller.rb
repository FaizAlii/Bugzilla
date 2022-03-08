# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_params

  def index
    @users = @users.search_by_name_and_email(params[:search]) if params[:search].present?

    respond_to do |format|
      format.js
      format.html
    end
  end

  private

  def set_params
    @user_type = params[:user_type]
    @users = User.where.not(id: current_user.id).with_role @user_type
    @project_id = params[:project_id]
    @users = @users.reject do |user|
      user.projects.exists?(@project_id)
    end
  end
end
