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

  def new?
    @user.has_role? :QA
  end

  def create?
    @user.has_role? :QA
  end

  def edit?
    (@user.has_role? :QA) || (@record.dev_id == @user.id)
  end

  def update?
    (@user.has_any_role? :QA) || (@record.dev_id == @user.id)
  end

  def assign?
    (@user.has_role? :Developer) && @record.dev_id.nil?
  end

  def destroy?
    @user.has_role? :QA
  end
end
