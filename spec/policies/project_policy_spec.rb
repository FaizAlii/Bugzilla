# frozen_string_literal: true
# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe ProjectPolicy do
#   subject { described_class.new(user, project) }

#   let!(:project) { create(:project, :project_with_manager) }
#   let!(:user) { create(:user, :dev) }

#   it { is_expected.not_to permit(:show?) }
#   it { is_expected.not_to permit(:create) }
#   it { is_expected.not_to permit(:new) }
#   it { is_expected.not_to permit(:update) }
#   it { is_expected.not_to permit(:edit) }
#   it { is_expected.not_to permit(:destroy) }
# end
