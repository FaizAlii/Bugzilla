# frozen_string_literal: true

class ProjectAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :user_id, uniqueness: { scope: :project_id }
  default_scope { order(created_at: :asc) }
end
