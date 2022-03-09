# frozen_string_literal: true

class BugPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.has_role? :QA
        user.bugs
      else
        scope.where(dev_id: user.id)
      end
    end
  end

  def new?
    user.has_role? :QA
  end

  def show?
    (user.has_any_role? :QA, :Manager) || record.project.users.exists?(user.id)
  end

  def edit?
    ((user.has_role? :QA) && (record.user_id == user.id)) || (record.dev_id == user.id)
  end

  def assign?
    (user.has_role? :Developer) && record.dev_id.nil? && record.project.project_assignments.exists?(user_id: user.id)
  end

  def destroy?
    (user.has_role? :QA) && (record.user_id == user.id)
  end

  alias create? new?
  alias update? edit?
end
