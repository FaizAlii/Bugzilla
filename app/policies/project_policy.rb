# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def create?
    @user.has_role? :Manager
  end

  def update?
    @user.has_role? :Manager
  end

  class Scope < Scope
    def resolve
      if user.has_role? :Manager
        scope.all
      else
        scope.where(user == scope.user)
      end
    end
  end
end
