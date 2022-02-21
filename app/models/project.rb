# frozen_string_literal: true

class Project < ApplicationRecord
  resourcify
  has_many :project_assignments, dependent: :destroy
  has_many :users, through: :project_assignments
  has_many :bugs, dependent: :destroy
end
