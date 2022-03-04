# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :project_assignments, dependent: :destroy
  has_many :users, through: :project_assignments
  has_many :bugs, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
end
