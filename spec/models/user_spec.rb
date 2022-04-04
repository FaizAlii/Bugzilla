# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  describe 'associations' do
    it { is_expected.to have_many(:projects).through(:project_assignments).class_name('Project') }
    it { is_expected.to have_many(:bugs) }
    it { is_expected.to have_and_belong_to_many(:roles) }
  end

  describe 'database columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:email).of_type(:string).with_options(default: '', null: false) }
    it { is_expected.to have_db_column(:encrypted_password).of_type(:string).with_options(default: '', null: false) }
    it { is_expected.to have_db_column(:reset_password_token).of_type(:string) }
    it { is_expected.to have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:remember_created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:confirmation_token).of_type(:string) }
    it { is_expected.to have_db_column(:confirmed_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:confirmation_sent_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_index(:confirmation_token).unique }
    it { is_expected.to have_db_index(:email).unique }
    it { is_expected.to have_db_index(:reset_password_token).unique }
  end

  describe 'creation' do
    it 'raises an empty name exception' do
      expect do
        create(:user, :blank_user_name, :manager)
      end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name can't be blank")
    end

    it 'raises an empty and invalid email exception' do
      expect do
        create(:user, :blank_email, :manager)
      end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email can't be blank, Email is invalid")
    end

    it 'raises an empty password exception' do
      expect do
        create(:user, :blank_password, :manager)
      end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Password can't be blank")
    end
  end
end
