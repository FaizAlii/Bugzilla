# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectsHelper, type: :helper do
  let!(:project) { create(:project, :project_with_manager) }

  describe '#user_roles_names' do
    it 'returns the names of the roles of the user' do
      expect(helper.roles(project.users.first)).to eq 'Manager'
    end
  end

  describe '#project_creator' do
    it 'returns the creator of the project' do
      expect(helper.creator(project)).to eq project.users.first
    end
  end
end
