# frozen_string_literal: true

class ProjectAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :project
  after_destroy :send_project_unassignment_mail
  after_save :send_project_assignment_mail

  validates :user_id, uniqueness: { scope: :project_id }
  default_scope { order(created_at: :asc) }

  def send_project_assignment_mail
    AssignmentMailer.with(project_id: project_id, user_id: user_id).project_assignment_email.deliver_later
  end

  def send_project_unassignment_mail
    AssignmentMailer.with(project_id: project_id, user_id: user_id).project_unassignment_email.deliver_later
  end
end
