# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :authorize_project, only: %i[edit update destroy]

  def index
    @projects = policy_scope(Project)
  end

  def show; end

  def new
    @project = current_user.projects.new
  end

  def edit; end

  def create
    @project = current_user.projects.create(project_params)
    authorize @project

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_path(@project), notice: 'Project was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_path(@project), notice: 'Project was successfully updated.' }
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
  rescue ActiveRecord::RecordNotFound
    redirect_to projects_path, alert: 'Project not found!'
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def authorize_project
    authorize @project
  end
end
