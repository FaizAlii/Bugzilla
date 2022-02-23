# frozen_string_literal: true

class AddIndexToBugAssignments < ActiveRecord::Migration[5.2]
  def change
    add_index :bug_assignments, %i[bug_id user_id], unique: true, name: 'by_bug_and_user'
  end
end
