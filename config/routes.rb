# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :users, only: :index

  resources :projects do
    resources :bugs do
      get 'assign', on: :member
    end
  end

  resources :bugs, only: [] do
    get 'user_bugs', on: :collection
  end

  resources :project_assignments, only: %i[create destroy]

  devise_scope :user do
    root to: 'devise/sessions#new'
  end
end
