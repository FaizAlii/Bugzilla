# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_show_params, only: :show
  before_action :set_assign_project_params, only: :assign_project
  before_action :set_assign_bug_params, only: :assign_bug
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
    AssignmentMailer.with(project: @project, user: @user).project_assignment_email.deliver_later
    redirect_to user_project_path(current_user, @project),
                notice: "#{@user.name} was successfully added to #{@project.name}."
  rescue StandardError
    redirect_to user_project_path(current_user, @project),
                notice: "#{@user.name} has already been added to #{@project.name}."
  end

  def assign_bug
    @user.bugs << @bug
    redirect_to project_bugs_path(@bug.project, @bug), notice: "#{@bug.title} has been successfully assigned to you."
  rescue StandardError
    redirect_to project_bugs_path(@bug.project, @bug), notice: "#{@bug.title} has already been assigned to you."
  end

  def remove_user_from_project
    @project.users.delete(@user.id)
    AssignmentMailer.with(project: @project, user: @user).project_unassignment_email.deliver_later
    redirect_to user_project_path(current_user, @project),
                notice: "#{@user.name} was successfully removed from #{@project.name}."
  end

  private

  def set_assign_project_params
    @user = User.find(params[:user_id])
    @project = Project.find(params[:project_id])
    @user_type = params[:user_type]
  end

  def set_assign_bug_params
    @user = User.find(params[:user_id])
    @bug = Bug.find(params[:bug_id])
  end

  def set_show_params
    @users = User.with_role params[:user_type]
    @user_type = params[:user_type]
    @project_id = params[:project_id]
  end

  def set_remove_user_params
    @project = Project.find(params[:project_id])
    @user = User.find(params[:user_id])
    authorize @user
  end
end
