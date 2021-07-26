# frozen_string_literal: true

Rails.application.routes.draw do
  namespace "api" do
    #resources :clinics, only: %i(index), controller: "/api/clinics"
    #resources :prefectures, only: %i(index) ,controller: "/api/prefectures" この書き方だとうまくjbuilderにマッチしない。。
    get 'clinics/index'
    get 'prefectures/index'
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
