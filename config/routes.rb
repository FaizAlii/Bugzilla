# frozen_string_literal: true

Rails.application.routes.draw do
  resources :bugs
  devise_for :users

  resources :users, only: [:index] do
    resources :projects
  end

  resources :projects, only: [] do
    resources :bugs
  end

  get '/users/:user_id/my_bugs', to: 'users#my_bugs', as: 'my_bugs'

  devise_scope :user do
    root to: 'devise/sessions#new'
  end
end
