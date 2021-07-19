# frozen_string_literal: true

class MedicineNotebookController < ApplicationController
  before_action :authenticate_user!
  def index
    @pets = current_user.pets
    if params[:pet_id]
      @pet = Pet.includes(:prescriptions, prescriptions: [:clinic, prescriptions_medicines: :medicine]).find_by(id: params[:pet_id])
    elsif @pets.present?
      @pet = current_user.pets.includes(:prescriptions, prescriptions: [:clinic, prescriptions_medicines: :medicine]).first
    end
  end
end
