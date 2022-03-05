# frozen_string_literal: true

class BugPolicy < ApplicationPolicy
  attr_reader :user, :bug

  class Scope < Scope
    def resolve
      if user.has_role? :QA
        user.bugs
      else
        scope.where(dev_id: user.id)
      end
    end
  end

  def create?
    @user.has_role? :QA
  end

  def edit?
    (@user.has_role? :QA) || (@record.dev_id == @user.id)
  end

  def update?
    @user.has_any_role? :QA, :Developer
  end

  def assign?
    @user.has_role? :Developer
  end

  def destroy?
    @user.has_role? :QA
  end
end
