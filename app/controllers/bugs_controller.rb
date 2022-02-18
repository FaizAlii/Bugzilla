# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :set_bug, only: %i[show edit update destroy]

  def index
    @project = Project.find(params[:project_id])
    @bugs = @project.bugs.all
  end

  def show
    @project = Project.find(params[:project_id])
  end

  def new
    @project = Project.find(params[:project_id])
    @bug = Bug.new
  end

  def edit
    @project = Project.find(params[:project_id])
  end

  def create
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.new(bug_params)

    respond_to do |format|
      if @bug.save
        current_user.bugs << @bug
        format.html { redirect_to project_bug_path(@project, @bug), notice: 'Bug was successfully created.' }
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
        format.html { redirect_to project_bug_path(@project, @bug), notice: 'Bug was successfully updated.' }
        format.json { render :show, status: :ok, location: @bug }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @bug.destroy

    respond_to do |format|
      format.html { redirect_to project_bugs_path(@project), notice: 'Bug was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_bug
    @bug = Bug.find(params[:id])
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :bug_type, :status, :screenshot)
  end
end
