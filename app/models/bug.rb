# frozen_string_literal: true

class Bug < ApplicationRecord
  belongs_to :project
  has_many :bug_assignments, dependent: :destroy
  has_many :users, through: :bug_assignments

  enum bug_type: { feature: 0, bug: 1 }
  enum status: { new: 0, started: 1, completed: 2 }, _prefix: true
end
