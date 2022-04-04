# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Devise::RegistrationsController, type: :controller do
  let(:new_user) { create(:user, :manager) }

  it 'configure_sign_up_params' do
    request.env['devise.mapping'] = Devise.mappings[:user]
    post :create, params: { user: attributes_for(:user) }
  end

  it 'configure_account_update_params' do
    request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in new_user
    put :update, params: { new_user: attributes_for(:user), id: new_user.id }
  end
end
