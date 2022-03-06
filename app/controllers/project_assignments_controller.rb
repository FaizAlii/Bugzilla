# frozen_string_literal: true

class ProjectAssignmentsController < ApplicationController
  before_action :set_params

  def create
    @project_assignment = ProjectAssignment.create(project_assignment_params)
    authorize @project_assignment

    if @project_assignment.save
      AssignmentMailer.with(project: @project, user: @user).project_assignment_email.deliver_later
      redirect_to project_path(@project),
                  notice: "#{@user.name} was successfully added to #{@project.name}."
    else
      redirect_to users_path(user_type: @user_type, project_id: @project.id),
                  alert: "#{@user.name} has already been added to #{@project.name}."
    end
  end

  def destroy
    @project_assignment = ProjectAssignment.find_by(project_assignment_params)
    authorize @project_assignment

    if @project_assignment.destroy
      AssignmentMailer.with(project: @project, user: @user).project_unassignment_email.deliver_later
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
end
