# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    enable_extension('citext')

    create_table :projects do |t|
      t.citext :name, null: false, index: { unique: true }
      t.text :description, limit: 255

      t.timestamps
    end
  end
end
