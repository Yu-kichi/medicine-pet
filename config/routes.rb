# frozen_string_literal: true

Rails.application.routes.draw do
  root "medicine_notebook#index"

  resources :pets do
    resources :medicine_notebook, only: %i(index)
    resources :clinics
  end

  resources :clinics do
    resources :medicines
  end

  resources :medicines
  resources :pets
end
