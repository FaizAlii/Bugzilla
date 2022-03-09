# frozen_string_literal: true

class ProjectAssignmentsController < ApplicationController
  before_action :set_params, except: :new
  before_action :set_new_params, only: :new
  before_action :authorize_project, only: :new

  def new
    @users = @users.search_by_name_and_email(params[:search]) if params[:search].present?

    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    @project_assignment = ProjectAssignment.new(project_assignment_params)
    authorize @project_assignment

    if @project_assignment.save
      redirect_to project_path(@project),
                  notice: "#{@user.name} was successfully added to #{@project.name}."
    else
      render :new, alert: "#{@user.name} has already been added to #{@project.name}."
    end
  end

  def destroy
    @project_assignment = ProjectAssignment.find(params[:id])
    authorize @project_assignment

    if @project_assignment.destroy
      redirect_to project_path(@project),
                  notice: "#{@user.name} was successfully removed from #{@project.name}."
    else
      redirect_to project_path(@project),
                  alert: "#{@user.name} has already been removed from #{@project.name}."
    end
  end

  private

  def project_assignment_params
    params.permit(:user_id, :project_id)
  end

  def set_params
    @project = Project.find(params[:project_id])
    @user = User.find(params[:user_id])
    @user_type = params[:user_type]
  end

  def set_new_params
    @user_type = params[:user_type]
    # @project_id = params[:project_id]
    @project = Project.find(params[:project_id])
    @users = User.unassigned_users(params[:project_id]).with_role(@user_type)
    @project_assignment = ProjectAssignment.new
  end

  def authorize_project
    authorize @project, :edit?
  end
end
