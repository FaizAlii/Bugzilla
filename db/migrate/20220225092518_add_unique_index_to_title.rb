# frozen_string_literal: true

class AddUniqueIndexToTitle < ActiveRecord::Migration[5.2]
  def change
    add_index :bugs, :title, unique: true
    change_column :bugs, :title, :string, limit: 255
  end
end
