# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @user_type = params[:user_type]
    @users = User.where.not(id: current_user.id).with_role @user_type
    @project_id = params[:project_id]
  end
end
