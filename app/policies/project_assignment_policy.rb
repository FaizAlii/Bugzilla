# frozen_string_literal: true

class ProjectAssignmentPolicy < ApplicationPolicy
  def create?
    (@user.has_role? :Manager)
  end

  alias destroy? create?
end
