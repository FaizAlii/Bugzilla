# frozen_string_literal: true

Rails.application.routes.draw do
  resources :bugs
  devise_for :users

  resources :users, only: [:index] do
    resources :projects
  end

  devise_scope :user do
    root to: 'devise/sessions#new'
  end
end
