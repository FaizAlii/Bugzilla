# frozen_string_literal: true

class DropBugAssignmentsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :bug_assignments do |t|
      t.bigint :user_id
      t.bigint :bug_id

      t.timestamps
    end
  end
end
