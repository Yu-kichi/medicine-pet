# frozen_string_literal: true

class ClinicsController < ApplicationController
  before_action :set_clinic, only: %i[show edit update destroy]
  before_action :set_pets, only: %i[new]
  before_action :authenticate_user!
  def index
    @clinics = Clinic.where(prefecture_id: params[:prefecture_id])
  end

  def show; end

  def new
    @pet = Pet.find_by(id: params[:pet_id])
    @clinic = Clinic.new
    @prescription = Prescription.find_by(id: params[:prescription_id])
  end

  def edit; end

  def update
    if @clinic.update(clinic_params)
      redirect_to pet_clinic_path(@clinic.pet_id, @clinic), notice: "病院情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @clinic.destroy
    redirect_to clinics_url, notice: "病院情報を削除しました"
  end

  private
    def set_clinic
      @clinic = Clinic.find(params[:id])
    end

    def clinic_params
      params.require(:clinic).permit(:name, :address, :telephone_number, :prefecture_id)
    end
end
