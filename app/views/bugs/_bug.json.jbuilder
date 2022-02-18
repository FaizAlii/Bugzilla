# frozen_string_literal: true

json.extract! bug, :id, :title, :description, :deadline, :type, :status, :screenshot, :created_at, :updated_at
json.url bug_url(bug, format: :json)
