# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users # , paths: 'users', controllers: { sessions: 'users/sessions' }

  resources :users, only: [:index] do
    resources :projects
  end

  devise_scope :user do
    root to: 'devise/sessions#new'
  end
end
