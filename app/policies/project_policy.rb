# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.has_any_role? :Manager, :QA
        scope.all
      else
        user.projects
      end
    end
  end

  def create?
    @user.has_role? :Manager
  end

  def update?
    (user.has_role? :Manager) && (record.users.first == user)
  end

  alias destroy? update?
end
