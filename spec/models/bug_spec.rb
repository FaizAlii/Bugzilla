# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bug, type: :model do
  before { create(:bug) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:deadline) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:bug_type) }
    it { is_expected.to validate_uniqueness_of(:title).scoped_to(:project_id) }
    it { is_expected.to validate_length_of(:title).is_at_most(255) }
    it { is_expected.not_to allow_value(DateTime.now).for(:deadline) }
    it { is_expected.to allow_value(1.second.from_now).for(:deadline) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:project) }
    it { is_expected.to have_one_attached(:image) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:bug_type).with_values(%i[feature bug]).backed_by_column_of_type(:integer) }
    it { is_expected.to define_enum_for(:status).with_values(%i[new started completed resolved]).with_prefix }
  end

  describe 'database columns' do
    it { is_expected.to have_db_column(:title).of_type(:string).with_options(limit: 255, null: false) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
    it { is_expected.to have_db_column(:deadline).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:bug_type).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:status).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:project_id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:dev_id).of_type(:integer) }
    it { is_expected.to have_db_index(:bug_type) }
    it { is_expected.to have_db_index(:dev_id) }
    it { is_expected.to have_db_index(:project_id) }
    it { is_expected.to have_db_index(:status) }
    it { is_expected.to have_db_index(:user_id) }
  end

  describe 'creation' do
    it 'raises an empty title exception' do
      expect do
        create(:bug, :blank_bug_title)
      end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Title can't be blank")
    end

    it 'raises an empty deadline exception' do
      expect do
        create(:bug, :blank_bug_deadline)
      end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Deadline can't be blank")
    end

    it 'raises a past deadline exception' do
      expect do
        create(:bug, :past_deadline)
      end.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Deadline cannot be in the past!')
    end

    it 'raises an empty bug type exception' do
      expect do
        create(:bug, :blank_bug_type)
      end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Bug type can't be blank")
    end

    it 'raises an empty status exception' do
      expect do
        create(:bug, :blank_bug_status)
      end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Status can't be blank")
    end

    it 'with png file should be valid' do
      expect do
        create(:bug, :with_png_image)
      end.not_to raise_error
    end

    it 'with gif file should be valid' do
      expect do
        create(:bug, :with_gif_image)
      end.not_to raise_error
    end

    it 'with txt file should not be valid' do
      expect do
        create(:bug, :with_txt_image)
      end.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Image needs to be a gif or png!')
    end
  end
end
