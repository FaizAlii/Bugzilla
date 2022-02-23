# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  # def index?
  #   true
  # end

  def create?
    @user.has_role? :Manager
  end

  def update?
    @user.has_role? :Manager
  end

  def destroy?
    @user.has_role? :Manager
  end

  class Scope < Scope
    def resolve
      if user.has_any_role? :Manager, :QA
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end
