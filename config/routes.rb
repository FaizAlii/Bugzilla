# frozen_string_literal: true

Rails.application.routes.draw do
  resources :bugs
  devise_for :users

  resources :users, only: [:index]
  get '/users/:user_id/my_bugs', to: 'users#my_bugs', as: 'my_bugs'
  resources :projects do
    resources :bugs
  end

  devise_scope :user do
    root to: 'devise/sessions#new'
  end
end
