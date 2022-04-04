# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let!(:project) { create(:project, :project_with_manager) }
  let!(:project2) { create(:project, :project_with_manager) }
  let!(:user) { project.users.first }
  let!(:user2) { create(:user, :dev_with_project) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    context 'with manager/qa' do
      let(:scope) { Pundit.policy_scope!(user, Project) }

      it 'returns all projects' do
        expect(scope.to_a).to match_array([project, project2, user2.projects.first])
      end
    end

    context 'with developer' do
      let(:scope) { Pundit.policy_scope!(user2, Project) }

      it 'returns the associated projects' do
        expect(scope.to_a).to match_array([user2.projects.first])
      end
    end

    it 'renders index template' do
      get :index
      expect(response).to render_template 'index'
    end

    it 'responds to html by default' do
      get :index
      expect(response.content_type).to eq 'text/html'
    end
  end

  describe 'GET #new' do
    it 'renders new form' do
      get :new
      expect(response).to render_template 'new'
    end

    it 'responds to html by default' do
      get :new
      expect(response.content_type).to eq 'text/html'
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'increments the total projects counter' do
        expect do
          post :create, params: { project: attributes_for(:project) }
        end.to change(Project, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not increment the total projects counter' do
        post :create, params: { project: attributes_for(:project, :blank_project_desc) }
        expect(assigns(:project)).to be_a_new(Project)
      end
    end

    context 'with unauthorized access' do
      it 'redirects back' do
        sign_in user2
        post :create, params: { project: attributes_for(:project) }
        expect(response).to be_redirect
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'redirects to show' do
        put :update, params: { project: attributes_for(:project), id: project.id }
        expect(response).to be_redirect
      end
    end

    context 'with invalid attributes' do
      it 'does not redirect to show' do
        put :update, params: { project: attributes_for(:project, :blank_project_desc), id: project.id }
        expect(response).not_to be_redirect
      end
    end
  end

  describe 'GET #show' do
    context 'with valid id' do
      it 'renders show template' do
        get :show, params: { id: project.id }
        expect(response).to render_template 'show'
      end

      it 'responds to html by default' do
        get :show, params: { id: project.id }
        expect(response.content_type).to eq 'text/html'
      end
    end

    context 'with invalid id' do
      it 'redirects back' do
        get :show, params: { id: '-1' }
        expect(response).to be_redirect
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with valid params' do
      it 'deletes the project' do
        expect { delete :destroy, params: { id: project.id } }.to change(Project, :count).by(-1)
      end
    end

    context 'with invalid params' do
      before do
        allow(project).to receive(:destroy).and_return(false)
        allow(Project).to receive(:find).and_return(project)
      end

      it 'is unsuccessful' do
        delete :destroy, params: { id: project.id }
        expect(response).not_to be_successful
      end
    end
  end
end
