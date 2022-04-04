# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectAssignment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:project) }
  end

  describe 'callbacks' do
    it { is_expected.to callback(:send_project_assignment_mail).after(:save) }
    it { is_expected.to callback(:send_project_unassignment_mail).after(:destroy) }
  end

  describe 'database columns' do
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:project_id).of_type(:integer) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_index(:project_id) }
    it { is_expected.to have_db_index(:user_id) }
  end
end
