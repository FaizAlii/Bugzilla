# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :authorize_project, only: %i[edit update destroy]
  before_action :authorize_new_project, only: %i[new create]

  def index
    @projects = policy_scope(Project)
    @projects = @projects.search_by_name(params[:search]) if params[:search].present?

    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    @users = @project.users.drop(1)
  end

  def new
    @project = current_user.projects.new
  end

  def edit; end

  def create
    @project = current_user.projects.new(project_params)
    @project.project_assignments.build(user: current_user)

    if @project.save
      redirect_to project_path(@project), notice: 'Project was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project), notice: 'Project was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @project.destroy
      redirect_to projects_path, notice: 'Project was successfully destroyed.'
    else
      redirect_to projects_path, alert: 'Project could not be destroyed.'
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to projects_path, alert: 'Project not found!'
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def authorize_project
    authorize @project
  end

  def authorize_new_project
    authorize Project
  end
end
