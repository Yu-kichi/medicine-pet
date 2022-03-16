# frozen_string_literal: true

class PrescriptionsController < ApplicationController
  before_action :set_prescription, only: %i[show edit]
  before_action :authenticate_user!
  before_action :set_pets, only: %i[show new edit]
  before_action :set_selected_pet, only: %i[show new edit]

  def show; end

  def new
    @prescription = Prescription.new
  end

  def edit
    @prefecture = @prescription.clinic
  end

  private
    def set_prescription
      if Prescription.find(params[:id]).pet.user == current_user
        @prescription = Prescription.find(params[:id])
      end
    end

    def prescription_params
      params.require(:prescription).permit(:date, :medical_fee, :medicine_fee, :pet_id, :clinic_id)
    end

    def set_selected_pet
      if params[:pet_id]
        @pet = current_user.pets.find_by(id: params[:pet_id])
      else
        @pet = @prescription.pet
      end
    end
end
