# frozen_string_literal: true

class ChangeBugsColumnsToNotNullable < ActiveRecord::Migration[5.2]
  def change
    # rubocop:disable Rails/BulkChangeTable
    change_column :bugs, :title, :string, null: false
    change_column :bugs, :status, :integer, null: false
    change_column :bugs, :bug_type, :integer, null: false
    change_column :bugs, :deadline, :datetime, null: false
    # rubocop:enable Rails/BulkChangeTable
  end
end
