# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :authorize_project, only: %i[show edit update destroy]
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
    @project_assignments = @project.project_assignments.includes(:user).drop(1)
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
      flash[:notice] = 'Project was successfully destroyed.'
    else
      flash[:alert] = @project.errors.full_messages.to_sentence
    end
    redirect_to projects_path
  end

  private

  def set_project
    @project = Project.find(params[:id])
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
