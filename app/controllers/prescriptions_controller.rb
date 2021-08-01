# frozen_string_literal: true

class PrescriptionsController < ApplicationController
  before_action :set_prescription, only: %i[show edit destroy]
  before_action :authenticate_user!
  before_action :set_user_pets
  before_action :set_selected_pet, only: %i[show new edit destroy]

  def show
  end

  def new
    @prescription = Prescription.new
  end

  def edit
    @prefecture = @prescription.clinic
  end

  def destroy
    @prescription.destroy
    if @pet
      redirect_to pet_medicine_notebook_index_path(@pet), notice: "prescription was successfully destroyed."
    else
      redirect_to prescriptions_url, notice: "prescription was successfully destroyed."
    end
  end

  private
    def set_prescription
      @prescription = Prescription.find(params[:id])
    end

    def prescription_params
      params.require(:prescription).permit(:date, :medical_fee, :medicine_fee, :pet_id, :clinic_id)
    end

    def set_user_pets
      @pets = current_user.pets
    end

    def set_selected_pet
      @pet = Pet.find_by(id: params[:pet_id])
    end
end
