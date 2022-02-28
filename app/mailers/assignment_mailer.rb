# frozen_string_literal: true

class AssignmentMailer < ApplicationMailer
  default from: 'faizz.ali@devsinc.com'

  def project_assignment_email
    @project = params[:project]
    @user = params[:user]
    mail(to: @user.email, subject: 'You have been assigned to a new Project!')
  end

  def project_unassignment_email
    @project = params[:project]
    @user = params[:user]
    mail(to: @user.email, subject: "You have been removed from #{@project.name}.")
  end
end
