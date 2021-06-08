# frozen_string_literal: true

Rails.application.routes.draw do
  get "medicine_notebook/index"
  resources :pets do
    resources :medicine_notebook
    resources :clinics
  end

  resources :medicines
  resources :clinics
  resources :pets
end
