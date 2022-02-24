# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  attr_reader :user, :project

  class Scope < Scope
  end

  def remove_user_from_project?
    @user.has_role? :Manager
  end

  def assign_bug?
    @user.has_role? :Developer
  end
end
