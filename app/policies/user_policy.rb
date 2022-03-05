# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  attr_reader :user, :project

  class Scope < Scope
  end
end
