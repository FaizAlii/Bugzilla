# frozen_string_literal: true

FactoryBot.define do
  factory :project_assignment do
    user { create(:user, :manager, :qa) }
    project
  end
end
