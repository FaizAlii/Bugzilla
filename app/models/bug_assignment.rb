# frozen_string_literal: true

class BugAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :bug
end
