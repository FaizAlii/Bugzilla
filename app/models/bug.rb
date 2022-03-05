# frozen_string_literal: true

class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :user
  belongs_to :dev, class_name: 'User', optional: true
  has_one_attached :image, dependent: :destroy

  validates :title, :status, :bug_type, :deadline, presence: true
  validates :title, uniqueness: { scope: :project_id }, length: { maximum: 255 }

  enum bug_type: { feature: 0, bug: 1 }
  enum status: { new: 0, started: 1, completed: 2, resolved: 3 }, _prefix: true
end
