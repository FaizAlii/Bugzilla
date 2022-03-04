# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :users, only: %i[show]

  resources :project_assignments, only: %i[create destroy]

  resources :projects do
    resources :bugs
  end

  get '/users/:user_id/my_bugs', to: 'users#my_bugs', as: 'my_bugs'
  get '/users/:user_id/assign_bug', to: 'users#assign_bug', as: 'assign_bug'

  devise_scope :user do
    root to: 'devise/sessions#new'
  end
end
