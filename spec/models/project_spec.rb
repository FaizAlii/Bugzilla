# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:users).through(:project_assignments).class_name('User') }
    it { is_expected.to have_many(:bugs) }
  end

  describe 'database columns' do
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(limit: 255, null: false) }
    it { is_expected.to have_db_column(:description).of_type(:text).with_options(null: false) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_index(:name).unique }
  end

  describe 'creation' do
    it 'raises an empty name exception' do
      expect do
        described_class.create!(attributes_for(:project, :blank_project_name))
      end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name can't be blank")
    end

    it 'raises an empty description exception' do
      expect do
        described_class.create!(attributes_for(:project, :blank_project_desc))
      end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Description can't be blank")
    end
  end
end
