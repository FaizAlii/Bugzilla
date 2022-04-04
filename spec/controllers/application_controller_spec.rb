# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let!(:user) { create(:user, :manager) }

  it 'after_sign_in_path_for' do
    expect(controller.after_sign_in_path_for(user)).to eq projects_path
  end
end
