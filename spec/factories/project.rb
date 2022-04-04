# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    sequence(:name, 10) { |n| "Projectt#{n}@gmail.com" }
    description { 'This is a cool project.' }
  end

  trait :project_with_manager do
    after(:create) { |project| project.users << FactoryBot.create(:user, :manager) }
  end

  trait :project_with_manager_and_qa do
    after(:create) { |project| project.users << FactoryBot.create(:user, :manager, :qa) }
  end

  trait :blank_project_name do
    name { nil }
  end

  trait :blank_project_desc do
    description { nil }
  end
end
