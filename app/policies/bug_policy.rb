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

  def edit?
    (user.has_role? :QA) || (record.dev_id == user.id)
  end

  def assign?
    (user.has_role? :Developer) && record.dev_id.nil?
  end

  alias destroy? new?
  alias create? new?
  alias update? edit?
end
