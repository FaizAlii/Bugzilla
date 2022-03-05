# frozen_string_literal: true

class ProjectAssignmentPolicy < ApplicationPolicy
  attr_reader :user, :project_assignment

  class Scope < Scope
  end

  def create?
    (@user.has_role? :Manager) && @user.project_assignments.exists?(@record)
  end

  def destroy?
    (@user.has_role? :Manager) && @user.project_assignments.exists?(@record)
  end
end
