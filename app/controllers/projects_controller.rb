# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :set_new_project, only: %i[create]

  def index
    @projects = current_user.projects.all # assign projects on the basis of user roles
  end

  def show; end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    authorize @project
    respond_to do |format|
      if @project.save
        current_user.projects << @project
        format.html { redirect_to users_path, notice: 'Project was successfully created.' }
        format.json { render 'users/index', status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @project
    respond_to do |format|
      if @project.update(project_params)
        format.html do
          redirect_to user_project_url(current_user, @project), notice: 'Project was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to user_projects_url(current_user), notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
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
end
