# frozen_string_literal: true

Rails.application.routes.draw do
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
