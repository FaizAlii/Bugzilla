# frozen_string_literal: true

FactoryBot.define do
  factory :bug do
    user { create(:user, :manager, :qa) }
    project
    sequence(:title, 10) { |n| "Bugg#{n}" }
    description { 'This is a new bug.' }
    deadline { Date.tomorrow.in_time_zone.change(hour: 11) }
    bug_type { 'bug' }
    status { 'new' }
  end

  trait :blank_bug_title do
    title { nil }
  end

  trait :blank_bug_deadline do
    deadline { nil }
  end

  trait :past_deadline do
    deadline { Date.current.in_time_zone }
  end

  trait :blank_bug_type do
    bug_type { nil }
  end

  trait :blank_bug_status do
    status { nil }
  end

  trait :with_png_image do
    image { fixture_file_upload(Rails.root.join('spec/files/image.png'), 'image/png') }
  end

  trait :with_gif_image do
    image { fixture_file_upload(Rails.root.join('spec/files/image.gif'), 'image/gif') }
  end

  trait :with_txt_image do
    image { fixture_file_upload(Rails.root.join('spec/files/test-image.txt'), 'image/txt') }
  end
end
