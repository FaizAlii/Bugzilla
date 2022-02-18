<<<<<<< HEAD
# frozen_string_literal: true

=======
>>>>>>> fe1665d (Bugs::Generate Bugs Scaffolding)
json.extract! bug, :id, :title, :description, :deadline, :type, :status, :screenshot, :created_at, :updated_at
json.url bug_url(bug, format: :json)
