# frozen_string_literal: true

class RemoveIndexFromBugTitle < ActiveRecord::Migration[5.2]
  def change
    remove_index :bugs, :title
  end
end
