# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :set_new_project, only: %i[create]
  before_action :authorize_project, only: %i[create edit update destroy]

  def index
    @projects = policy_scope(Project)
  end

  def show; end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    respond_to do |format|
      if @project.save
        current_user.projects << @project
        format.html { redirect_to project_path(@project), notice: 'Project was successfully created.' }
        format.json { render 'users/index', status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html do
          redirect_to project_path(@project), notice: 'Project was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @project.destroy
        format.html { redirect_to projects_path, notice: 'Project was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to projects_path, notice: 'Project could not be destroyed.' }
      end
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def set_new_project
    @project = Project.new(project_params)
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def authorize_project
    authorize @project
  end
end
