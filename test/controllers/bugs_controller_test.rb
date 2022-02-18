<<<<<<< HEAD
# frozen_string_literal: true

=======
>>>>>>> fe1665d (Bugs::Generate Bugs Scaffolding)
require 'test_helper'

class BugsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bug = bugs(:one)
  end

<<<<<<< HEAD
  test 'should get index' do
=======
  test "should get index" do
>>>>>>> fe1665d (Bugs::Generate Bugs Scaffolding)
    get bugs_url
    assert_response :success
  end

<<<<<<< HEAD
  test 'should get new' do
=======
  test "should get new" do
>>>>>>> fe1665d (Bugs::Generate Bugs Scaffolding)
    get new_bug_url
    assert_response :success
  end

<<<<<<< HEAD
  test 'should create bug' do
    assert_difference('Bug.count') do
      post bugs_url,
           params: { bug: { deadline: @bug.deadline, description: @bug.description, screenshot: @bug.screenshot,
                            status: @bug.status, title: @bug.title, type: @bug.type } }
=======
  test "should create bug" do
    assert_difference('Bug.count') do
      post bugs_url, params: { bug: { deadline: @bug.deadline, description: @bug.description, screenshot: @bug.screenshot, status: @bug.status, title: @bug.title, type: @bug.type } }
>>>>>>> fe1665d (Bugs::Generate Bugs Scaffolding)
    end

    assert_redirected_to bug_url(Bug.last)
  end

<<<<<<< HEAD
  test 'should show bug' do
=======
  test "should show bug" do
>>>>>>> fe1665d (Bugs::Generate Bugs Scaffolding)
    get bug_url(@bug)
    assert_response :success
  end

<<<<<<< HEAD
  test 'should get edit' do
=======
  test "should get edit" do
>>>>>>> fe1665d (Bugs::Generate Bugs Scaffolding)
    get edit_bug_url(@bug)
    assert_response :success
  end

<<<<<<< HEAD
  test 'should update bug' do
    patch bug_url(@bug),
          params: { bug: { deadline: @bug.deadline, description: @bug.description, screenshot: @bug.screenshot,
                           status: @bug.status, title: @bug.title, type: @bug.type } }
    assert_redirected_to bug_url(@bug)
  end

  test 'should destroy bug' do
=======
  test "should update bug" do
    patch bug_url(@bug), params: { bug: { deadline: @bug.deadline, description: @bug.description, screenshot: @bug.screenshot, status: @bug.status, title: @bug.title, type: @bug.type } }
    assert_redirected_to bug_url(@bug)
  end

  test "should destroy bug" do
>>>>>>> fe1665d (Bugs::Generate Bugs Scaffolding)
    assert_difference('Bug.count', -1) do
      delete bug_url(@bug)
    end

    assert_redirected_to bugs_url
  end
end
