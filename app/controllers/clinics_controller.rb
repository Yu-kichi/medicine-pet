# frozen_string_literal: true

class ClinicsController < ApplicationController
  before_action :set_clinic, only: %i[show edit update destroy]
  before_action :authenticate_user!
  def index
    @pets = current_user.pets
    @pet = Pet.find_by(id: params[:pet_id])
    @clinics = Clinic.all
  end

  def show
    @pet = Pet.find_by(id: params[:pet_id])
  end

  def new
    @pets = current_user.pets
    @pet = Pet.find_by(id: params[:pet_id])
    @clinic = Clinic.new
    @prescription = Prescription.find_by(id: params[:prescription_id])
  end

  def edit
    @pet = Pet.find_by(id: params[:pet_id])
  end

  def update
    if @clinic.update(clinic_params)
      redirect_to pet_clinic_path(@clinic.pet_id, @clinic), notice: "Clinic was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @clinic.destroy
    redirect_to clinics_url, notice: "Clinic was successfully destroyed."
  end

  private
    def set_clinic
      @clinic = Clinic.find(params[:id])
    end

    def clinic_params
      params.require(:clinic).permit(:name, :address, :telephone_number, :prefecture_id)
    end
end
