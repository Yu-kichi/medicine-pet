# frozen_string_literal: true

Rails.application.routes.draw do
  resources :medicines
  resources :clinics
  resources :pets
end
