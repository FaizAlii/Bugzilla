# frozen_string_literal: true

class AddLimitToProjectAndRoleNames < ActiveRecord::Migration[5.2]
  def change
    change_column :projects, :name, :string, limit: 255
    change_column :roles, :name, :string, limit: 255
  end
end
