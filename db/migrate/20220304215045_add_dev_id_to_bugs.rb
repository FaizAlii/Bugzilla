# frozen_string_literal: true

class AddDevIdToBugs < ActiveRecord::Migration[5.2]
  def change
    add_reference :bugs, :dev, index: true
    add_foreign_key :bugs, :users, column: :dev_id
  end
end
