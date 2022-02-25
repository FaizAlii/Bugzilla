# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @projects = current_user.projects
  end

  def my_bugs
    @bugs = current_user.bugs
  end
end
