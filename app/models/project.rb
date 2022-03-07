# frozen_string_literal: true

class Project < ApplicationRecord
  include PgSearch

  has_many :project_assignments, dependent: :destroy
  has_many :users, through: :project_assignments
  has_many :bugs, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true

  pg_search_scope :search_by_name, against: :name, using: { tsearch: { prefix: true } }
end
