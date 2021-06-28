# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  root "medicine_notebook#index"

  resources :pets do
    resources :prescriptions
    resources :medicine_notebook, only: %i(index)
  end

  resources :prescriptions do
    resources :prescriptions_medicines
  end

  #resources :prescriptions_medicines
  resources :clinics
  resources :medicines
  resources :pets
end
