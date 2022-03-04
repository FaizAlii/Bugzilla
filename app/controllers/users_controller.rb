# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_show_params, only: :show
  before_action :set_assign_bug_params, only: :assign_bug

  def my_bugs
    @bugs = current_user.bugs
  end

  def show; end

  def assign_bug
    @user.bugs << @bug
    redirect_to project_bugs_path(@bug.project, @bug), notice: "#{@bug.title} has been successfully assigned to you."
  rescue StandardError
    redirect_to project_bugs_path(@bug.project, @bug), alert: "#{@bug.title} has already been assigned to you."
  end

  private

  def set_assign_bug_params
    @user = User.find(params[:user_id])
    @bug = Bug.find(params[:bug_id])
  end

  def set_show_params
    @users = User.where.not(id: current_user.id).with_role params[:user_type]
    @user_type = params[:user_type]
    @project_id = params[:project_id]
  end
end
