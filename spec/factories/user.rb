# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Faiz' }
    sequence(:email, 10) { |n| "faiz#{n}@gmail.com" }
    password { 'faizali' }
    confirmed_at { Time.current }
  end

  trait :manager do
    before(:create) { |user| user.add_role(:Manager) }
  end

  trait :qa do
    before(:create) { |user| user.add_role(:QA) }
  end

  trait :dev do
    before(:create) { |user| user.add_role(:Developer) }
  end

  trait :user_with_project do
    manager
    after(:create) { |user| user.projects << FactoryBot.create(:project) }
  end

  trait :dev_with_project do
    dev
    after(:create) { |user| user.projects << FactoryBot.create(:project) }
  end

  trait :blank_user_name do
    name { nil }
  end

  trait :blank_email do
    email { nil }
  end

  trait :blank_password do
    password { nil }
  end
end
