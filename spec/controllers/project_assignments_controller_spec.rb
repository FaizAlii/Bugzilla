# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectAssignmentsController, type: :controller do
  let!(:new_project_assignment) { create(:project_assignment) }
  let!(:project) { create(:project, :project_with_manager) }
  let!(:project2) { create(:project, :project_with_manager_and_qa) }

  before do
    sign_in project.users.first
  end

  describe 'GET #new' do
    it 'renders new form' do
      get :new, params: { user_type: 'QA', project_id: project.id }
      expect(response).to render_template 'new'
    end

    it 'responds to html by default' do
      get :new, params: { user_type: 'QA', project_id: project.id }
      expect(response.content_type).to eq 'text/html'
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'increments the total project assignments counter' do
        expect do
          post :create, params: { project_id: project.id, user_id: project2.users.first.id, user_type: 'QA' }
        end.to change(ProjectAssignment, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      before do
        allow(ProjectAssignment).to receive(:create).and_return(false)
        allow(ProjectAssignment).to receive(:find).and_return(ProjectAssignment)
      end

      it 'renders new template' do
        post :create, params: { project_id: project.id, user_id: project2.users.first.id, user_type: 'QA' }
        post :create, params: { project_id: project.id, user_id: project2.users.first.id, user_type: 'QA' }
        expect(response).to render_template 'new'
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      sign_in new_project_assignment.project.users.first
    end

    context 'with valid params' do
      it 'deletes the project assignment' do
        expect do
          delete :destroy, params: { id: new_project_assignment.id, project_id: new_project_assignment.project_id,
                                     user_id: new_project_assignment.user_id, user_type: 'QA' }
        end.to change(ProjectAssignment, :count).by(-1)
      end
    end

    context 'with invalid params' do
      before do
        allow(new_project_assignment).to receive(:destroy).and_return(false)
        allow(ProjectAssignment).to receive(:find).and_return(new_project_assignment)
      end

      it 'is unsuccessful' do
        delete :destroy, params: { id: new_project_assignment.id, project_id: new_project_assignment.project_id,
                                   user_id: new_project_assignment.user_id, user_type: 'QA' }
        expect(response).not_to be_successful
      end
    end
  end
end
