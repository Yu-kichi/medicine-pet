# frozen_string_literal: true

Rails.application.routes.draw do
  get "welcome", to: "welcome#index", as: "welcome"
  get "tos", to: "welcome#tos", as: "tos"
  get "policy", to: "welcome#policy", as: "policy"
  root "medicine_notebook#index"

  namespace "api", { format: "json" } do
    resources :clinics, only: %i[edit update show create]
    resources :prefectures, only: %i[index]
    resources :medicines, only: %i[index]
    resources :medicine_notebook, only: %i[index show]
    resources :pets, only: %i[index]
    resources :prescriptions, only: %i[show create update edit destroy]
    resources :prescriptions_medicines, only: %i[ create update edit destroy show]
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  resources :pets do
    resources :medicine_notebook, only: %i[index]
  end

  resources :prescriptions, only: %i[index new edit show] do
    resources :prescriptions_medicines
  end

  resources :clinics, only: %i[index show new edit destroy]
  resources :medicines
end
