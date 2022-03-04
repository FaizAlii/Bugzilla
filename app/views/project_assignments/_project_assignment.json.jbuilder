# frozen_string_literal: true

json.extract! project_assignment, :id, :created_at, :updated_at
json.url project_assignment_url(project_assignment, format: :json)
