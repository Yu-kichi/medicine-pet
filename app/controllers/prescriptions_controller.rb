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
      @prescription = Prescription.find(params[:id])
    end

    def prescription_params
      params.require(:prescription).permit(:date, :medical_fee, :medicine_fee, :pet_id, :clinic_id)
    end

    def set_selected_pet
      if params[:pet_id]
        @pet = Pet.find_by(id: params[:pet_id])
      else
        @pet = @prescription.pet
      end
    end
end
