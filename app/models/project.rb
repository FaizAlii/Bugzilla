class Project < ApplicationRecord
  has_many :project_assignments
  has_many :users, through: :project_assignments
end
