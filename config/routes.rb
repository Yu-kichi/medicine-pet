# frozen_string_literal: true

Rails.application.routes.draw do
  namespace "api", { format: "json" } do
    # resources :clinics, only: %i(index), controller: "/api/clinics"
    # resources :prefectures, only: %i(index) ,controller: "/api/prefectures" この書き方だとうまくjbuilderにマッチしない。。
    resources :clinics, only: %i(show create)
    get "prefectures/index"
    get "medicines/index"
    get "medicine_notebook/index"
    resources :prescriptions, only: %i(index show create update edit destroy)
    resources :prescriptions_medicines, only: %i(index create update edit destroy show)
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  root "medicine_notebook#index"

  resources :prefectures, only: [] do
    resources :clinics, only: :index
  end

  resources :pets do
    resources :prescriptions
    resources :medicine_notebook, only: %i(index)
  end

  resources :prescriptions do
    resources :prescriptions_medicines
  end

  resources :clinics
  resources :medicines
end
