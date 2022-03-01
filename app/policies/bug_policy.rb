# frozen_string_literal: true

class BugPolicy < ApplicationPolicy
  attr_reader :user, :bug

  class Scope < Scope
  end

  def create?
    @user.has_role? :QA
  end

  def edit?
    (@user.has_role? :QA) || (@user.bugs.include? @record)
  end

  def update?
    @user.has_any_role? :QA, :Developer
  end

  def destroy?
    @user.has_role? :QA
  end
end
