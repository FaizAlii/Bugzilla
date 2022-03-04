# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :set_bug, only: %i[show edit update destroy]
  before_action :set_project
  before_action :set_new_bug, only: %i[create]
  before_action :authorize_bug, only: %i[create edit update destroy]
  before_action :set_bug_type, only: %i[create edit update destroy]

  def index
    @bugs = @project.bugs.all
  end

  def show; end

  def new
    @bug = Bug.new
  end

  def edit; end

  def create
    respond_to do |format|
      if @bug.save
        current_user.bugs << @bug
        format.html do
          redirect_to project_bug_path(@project, @bug), notice: "#{@bug_type} was successfully created."
        end
        format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @bug.update(bug_params)
        format.html do
          redirect_to project_bug_path(@project, @bug), notice: "#{@bug_type} was successfully updated."
        end
        format.json { render :show, status: :ok, location: @bug }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @bug.destroy
        format.html { redirect_to project_bugs_path(@project), notice: "#{@bug_type} was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to project_bugs_path(@project), notice: "#{@bug_type} could not be destroyed!" }
      end
    end
  end

  private

  def set_bug
    @bug = Bug.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to projects_path, alert: 'Bug not found!'
  end

  def set_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to projects_path, alert: 'Project not found!'
  end

  def set_new_bug
    @bug = @project.bugs.new(bug_params)
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :bug_type, :status, :image)
  end

  def authorize_bug
    authorize @bug
  end

  def set_bug_type
    @bug_type = @bug.bug_type.capitalize
  end
end
