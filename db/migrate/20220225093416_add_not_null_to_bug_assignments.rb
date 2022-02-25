# frozen_string_literal: true

class AddNotNullToBugAssignments < ActiveRecord::Migration[5.2]
  def change
    change_column_null :bug_assignments, :user_id, false
    change_column_null :bug_assignments, :bug_id, false
  end
end
