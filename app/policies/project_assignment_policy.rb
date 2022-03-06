# frozen_string_literal: true

class ProjectAssignmentPolicy < ApplicationPolicy
  attr_reader :user, :project_assignment

  class Scope < Scope
    def resolve; end
  end

  def create?
    (@user.has_role? :Manager)
  end

  def destroy?
    (@user.has_role? :Manager)
  end
end
