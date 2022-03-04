# frozen_string_literal: true

require 'application_system_test_case'

class ProjectAssignmentsTest < ApplicationSystemTestCase
  setup do
    @project_assignment = project_assignments(:one)
  end

  test 'visiting the index' do
    visit project_assignments_url
    assert_selector 'h1', text: 'Project Assignments'
  end

  test 'creating a Project assignment' do
    visit project_assignments_url
    click_on 'New Project Assignment'

    click_on 'Create Project assignment'

    assert_text 'Project assignment was successfully created'
    click_on 'Back'
  end

  test 'updating a Project assignment' do
    visit project_assignments_url
    click_on 'Edit', match: :first

    click_on 'Update Project assignment'

    assert_text 'Project assignment was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Project assignment' do
    visit project_assignments_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Project assignment was successfully destroyed'
  end
end
