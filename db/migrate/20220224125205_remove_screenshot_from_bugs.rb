# frozen_string_literal: true

class RemoveScreenshotFromBugs < ActiveRecord::Migration[5.2]
  def change
    remove_column :bugs, :screenshot, :string
  end
end
