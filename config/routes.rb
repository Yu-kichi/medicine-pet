# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root "medicine_notebook#index"

  resources :pets do
    resources :medicine_notebook, only: %i(index)
    resources :clinics
    resources :medicines
  end

  resources :clinics do
    resources :medicines
  end

  resources :medicines
  resources :pets
end
