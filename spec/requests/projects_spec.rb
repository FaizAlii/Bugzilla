# frozen_string_literal: true
# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe 'Projects', type: :request do
#   let(:user) { FactoryBot.build(:user, :Manager) }

#   describe 'GET #show' do
#     before do
#       post user_session_path, params: { email: user.email, password: user.password }
#       # sign_in user
#       # follow_redirect!
#       get project_path(:id)
#     end

#     it { is_expected.to render_template('show') }
#     it { is_expected.to render_template(partial: '_project') }
#   end
# end
