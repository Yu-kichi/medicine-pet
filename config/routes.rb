# frozen_string_literal: true

Rails.application.routes.draw do
  get "welcome", to: "welcome#index", as: "welcome"
  get "tos", to: "welcome#tos", as: "tos"
  get "policy", to: "welcome#policy", as: "policy"
  root "medicine_notebook#index"

  namespace "api", { format: "json" } do
    resources :clinics, only: %i[edit update show create]
    get "prefectures/index"
    get "medicines/index"
    get "medicine_notebook/index"
    get "pets/index"
    resources :prescriptions, only: %i[show create update edit destroy]
    resources :prescriptions_medicines, only: %i[ create update edit destroy show]
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  resources :prefectures, only: [] do
    resources :clinics, only: :index
  end

  resources :pets do
    resources :prescriptions, only: %i[show new create edit update destroy]
    resources :medicine_notebook, only: %i[index]
  end

  resources :prescriptions, only: [] do
    resources :prescriptions_medicines
  end

  resources :clinics
  resources :medicines
end
