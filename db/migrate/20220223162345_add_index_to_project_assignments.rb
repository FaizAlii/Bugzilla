# frozen_string_literal: true

class AddIndexToProjectAssignments < ActiveRecord::Migration[5.2]
  def change
    add_index :project_assignments, %i[project_id user_id], unique: true, name: 'by_project_and_user'
  end
end
