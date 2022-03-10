# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :set_bug, only: %i[show edit update assign destroy]
  before_action :set_project, except: :user_bugs
  before_action :authorize_bug, only: %i[show edit update assign destroy]
  before_action :authorize_new_bug, only: %i[new create]
  before_action :authorize_project, only: :index
  before_action :set_bug_type, only: %i[edit update destroy]

  def index
    @bugs = @project.bugs
    @bugs = @bugs.search_by_title(params[:search]) if params[:search].present?

    respond_to do |format|
      format.js
      format.html
    end
  end

  def show; end

  def new
    @bug = @project.bugs.new
  end

  def edit; end

  def create
    @bug = @project.bugs.new(bug_params)
    if @bug.save
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
    if @bug.update(dev_id: current_user.id)
      flash[:notice] = "#{@bug.bug_type.capitalize} was successfully assigned to you."
    else
      flash[:alert] = @bug.errors.full_messages.to_sentence
    end
    redirect_to project_bug_path(@project, @bug)
  end

  def user_bugs
    @bugs = policy_scope(Bug)
  end

  def destroy
    if @bug.destroy
      flash[:notice] = "#{@bug_type} was successfully destroyed."
    else
      flash[:alert] = @bug.errors.full_messages.to_sentence
    end
    redirect_to project_bugs_path(@project)
  end

  private

  def set_bug
    @bug = Bug.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :bug_type, :status,
                                :image).merge(user_id: current_user.id)
  end

  def authorize_bug
    authorize @bug
  end

  def authorize_new_bug
    authorize Bug
  end

  def authorize_project
    authorize @project, :show?
  end

  def set_bug_type
    @bug_type = @bug.bug_type.capitalize
  end
end
