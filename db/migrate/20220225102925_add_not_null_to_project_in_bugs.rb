# frozen_string_literal: true

class AddNotNullToProjectInBugs < ActiveRecord::Migration[5.2]
  def change
    change_column_null :bugs, :project_id, false
  end
end
