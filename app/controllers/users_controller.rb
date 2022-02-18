# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def my_bugs
    @bugs = current_user.bugs
  end
end
