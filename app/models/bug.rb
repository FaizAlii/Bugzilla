# frozen_string_literal: true

class Bug < ApplicationRecord
  include PgSearch::Model

  belongs_to :project
  belongs_to :user
  belongs_to :dev, class_name: 'User', optional: true
  has_one_attached :image, dependent: :destroy

  enum bug_type: { feature: 0, bug: 1 }
  enum status: { new: 0, started: 1, completed: 2, resolved: 3 }, _prefix: true

  validates :title, :status, :bug_type, :deadline, presence: true
  validates :title, uniqueness: { scope: :project_id }, length: { maximum: 255 }
  validate :image_type
  validate :deadline_cannot_be_in_the_past, if: :deadline_changed?

  pg_search_scope :search_by_title, against: :title, using: { tsearch: { prefix: true } }

  private

  def image_type
    return unless image.attached?

    errors.add(:image, 'needs to be a gif or png!') unless image.content_type.in?(%('image/gif image/png'))
  end

  def deadline_cannot_be_in_the_past
    errors.add(:deadline, 'cannot be in the past!') if deadline < Time.current
  end
end
