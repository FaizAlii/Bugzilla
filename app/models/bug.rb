# frozen_string_literal: true

class Bug < ApplicationRecord
  belongs_to :project
  has_many :bug_assignments, dependent: :destroy
  has_many :users, through: :bug_assignments
end
