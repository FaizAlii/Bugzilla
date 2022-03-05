# frozen_string_literal: true

class AddUserReferenceToBugs < ActiveRecord::Migration[5.2]
  def change
    add_reference :bugs, :user, foreign_key: true, unique: true
  end
end
