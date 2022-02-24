# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_assign_params, only: :assign_project
  before_action :set_show_params, only: :show
  before_action :set_remove_user_params, only: :remove_user_from_project

  def index
    @projects = current_user.projects
  end

  def my_bugs
    @bugs = current_user.bugs
  end

  def show; end

  def assign_project
    @user.projects << @project
    redirect_to project_path(@project), notice: "#{@user.name} was successfully added to #{@project.name}."
  rescue StandardError
    redirect_to project_path(@project), notice: "#{@user.name} has already been added to #{@project.name}."
  end

  def remove_user_from_project
    @project.users.delete(@user.id)
    redirect_to project_path(@project), notice: "#{@user.name} was successfully removed from #{@project.name}."
  end

  private

  def set_assign_params
    @user = User.find(params[:user_id])
    @project = Project.find(params[:project_id])
    @user_type = params[:user_type]
  end

  def set_show_params
    @users = User.with_role params[:user_type]
    @user_type = params[:user_type]
    @project_id = params[:project_id]
  end

  def set_remove_user_params
    @project = Project.find(params[:project_id])
    @user = User.find(params[:user_id])
  end
end
