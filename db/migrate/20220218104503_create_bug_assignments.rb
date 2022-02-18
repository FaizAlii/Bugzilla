# frozen_string_literal: true

class CreateBugAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :bug_assignments do |t|
      t.references :user, foreign_key: true
      t.references :bug, foreign_key: true

      t.timestamps
    end
  end
end
