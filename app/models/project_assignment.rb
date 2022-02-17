# frozen_string_literal: true

class ProjectAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :project
end
