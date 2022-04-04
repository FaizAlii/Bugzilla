# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BugsController, type: :controller do
  let!(:bug) { create(:bug) }
  let!(:bug2) { create(:bug) }
  let!(:user) { bug.user }
  let!(:project) { bug.project }
  let!(:dev) { create(:user, :dev_with_project) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'renders index template' do
      get :index, params: { project_id: project.id }
      expect(response).to render_template 'index'
    end

    it 'responds to html by default' do
      get :index, params: { project_id: project.id }
      expect(response.content_type).to eq 'text/html'
    end
  end

  describe 'GET #new' do
    it 'renders new form' do
      get :new, params: { project_id: project.id }
      expect(response).to render_template 'new'
    end

    it 'responds to html by default' do
      get :new, params: { project_id: project.id }
      expect(response.content_type).to eq 'text/html'
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'increments the total bugs counter' do
        expect do
          post :create,
               params: { bug: attributes_for(:bug), project_id: project.id, user_id: user.id }
        end.to change(Bug, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not increment the total bugs counter' do
        post :create,
             params: { bug: attributes_for(:bug, :blank_bug_title), project_id: project.id, user_id: user.id }
        expect(assigns(:bug)).to be_a_new(Bug)
      end

      it 'is unsuccessful' do
        post :create,
             params: { bug: attributes_for(:bug, :blank_bug_title), project_id: project.id, user_id: user.id }
        expect(response).not_to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'redirects to show' do
        put :update,
            params: { bug: attributes_for(:bug), project_id: project.id, user_id: user.id, id: bug.id }
        expect(response).to be_redirect
      end
    end

    context 'with invalid attributes' do
      it 'does not redirect to show' do
        put :update,
            params: { bug: attributes_for(:bug, :blank_bug_title), project_id: project.id, user_id: user.id,
                      id: bug.id }
        expect(response).not_to be_redirect
      end
    end
  end

  describe 'GET #assign' do
    before { sign_in dev }

    context 'with valid attributes' do
      it 'updates the bug' do
        dev.projects << project
        get :assign, params: { project_id: project.id, id: bug.id }
        expect(response).to be_redirect
      end
    end

    context 'with invalid attributes' do
      it 'is unsuccessful' do
        # rubocop:disable RSpec/AnyInstance
        allow_any_instance_of(Bug).to receive(:update).and_return false
        # rubocop:enable RSpec/AnyInstance
        dev.projects << bug.project
        get :assign, params: { project_id: bug.project_id, id: bug.id }
        expect(response).not_to be_successful
      end
    end
  end

  describe 'GET #show' do
    it 'renders show template' do
      get :show, params: { project_id: bug.project_id, id: bug.id }
      expect(response).to render_template 'show'
    end

    it 'responds to html by default' do
      get :show, params: { project_id: bug.project_id, id: bug.id }
      expect(response.content_type).to eq 'text/html'
    end
  end

  describe 'DELETE #destroy' do
    context 'with valid params' do
      it 'deletes the bug' do
        expect { delete :destroy, params: { id: bug.id, project_id: project.id } }.to change(Bug, :count).by(-1)
      end
    end

    context 'with invalid params' do
      before do
        allow(bug).to receive(:destroy).and_return(false)
        allow(Bug).to receive(:find).and_return(bug)
      end

      it 'raises an exception' do
        delete :destroy, params: { id: bug.id, project_id: project.id }
        expect(response).not_to be_successful
      end
    end
  end

  describe 'GET #user_bugs' do
    context 'with qa' do
      it "renders user's bugs" do
        get :user_bugs
        expect(Pundit.policy_scope!(user, Bug).to_a).to match_array([bug])
      end
    end

    context 'with manager/dev' do
      it "renders dev's bugs" do
        dev.projects << bug2.project
        bug2.update(dev_id: dev.id)
        expect(Pundit.policy_scope!(dev, Bug).to_a).to match_array([bug2])
      end
    end
  end
end
