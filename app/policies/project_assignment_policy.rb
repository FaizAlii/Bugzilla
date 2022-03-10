# frozen_string_literal: true

class ProjectAssignmentPolicy < ApplicationPolicy
  def create?
    (user.has_role? :Manager) && record.project.users.first == user
  end

  alias destroy? create?
end
