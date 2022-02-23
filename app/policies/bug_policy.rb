# frozen_string_literal: true

class BugPolicy < ApplicationPolicy
  attr_reader :user, :bug

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    @user.has_role? :QA
  end

  def update?
    @user.has_any_role? :QA, :Developer
  end

  def destroy?
    @user.has_role? :QA
  end
end
