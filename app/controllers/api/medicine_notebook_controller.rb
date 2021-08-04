# frozen_string_literal: true

class Api::MedicineNotebookController < ApplicationController
  before_action :authenticate_user!
  def index
    if params[:pet_id]
      @pet = Pet.includes(:prescriptions, prescriptions: [:clinic, prescriptions_medicines: :medicine]).order("prescriptions.date DESC").find_by(id: params[:pet_id])
      # @pet = Pet.joins(:prescriptions).includes(:prescriptions, prescriptions: [:clinic, prescriptions_medicines: :medicine]).order("prescriptions.date").find_by(id: params[:pet_id])
    elsif @pets.present?
      @pet = current_user.pets.includes(:prescriptions, prescriptions: [:clinic, prescriptions_medicines: :medicine]).first
    end
  end
end
