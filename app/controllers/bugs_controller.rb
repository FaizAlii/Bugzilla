# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :set_bug, only: %i[show edit update assign destroy]
  before_action :set_project, except: :user_bugs
  before_action :authorize_bug, only: %i[edit update destroy]
  before_action :set_bug_type, only: %i[edit update destroy]
  before_action :assign_bug, only: :assign

  def index
    @bugs = @project.bugs.all

    return unless params[:search] && params[:search] != ''

    @search_results = @bugs.search_by_title(params[:search])
    respond_to do |format|
      format.js { render partial: 'search_results' }
    end
  end

  def show; end

  def new
    @bug = @project.bugs.new
  end

  def edit; end

  def create
    @bug = @project.bugs.create(bug_params)
    authorize @bug

    if @bug.valid?
      redirect_to project_bug_path(@project, @bug), notice: "#{@bug.bug_type.capitalize} was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @bug.update(bug_params)
      redirect_to project_bug_path(@project, @bug), notice: "#{@bug_type} was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def assign
    if @bug.save
      redirect_to project_bug_path(@project, @bug),
                  notice: "#{@bug.bug_type.capitalize} was successfully assigned to you."
    else
      redirect_to project_bug_path(@project, @bug),
                  alert: "#{@bug.bug_type.capitalize} cannot be assigned to you."
    end
  end

  def user_bugs
    @bugs = policy_scope(Bug)
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

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :bug_type, :status,
                                :image).merge(user_id: current_user.id)
  end

  def authorize_bug
    authorize @bug
  end

  def set_bug_type
    @bug_type = @bug.bug_type.capitalize
  end

  def assign_bug
    if @bug.dev_id == current_user.id
      redirect_to project_bug_path(@project, @bug),
                  alert: "#{@bug.bug_type.capitalize} cannot be assigned to you."
    else
      @bug.dev_id = current_user.id
    end
  end
end
