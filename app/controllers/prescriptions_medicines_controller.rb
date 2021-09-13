# frozen_string_literal: true

class PrescriptionsMedicinesController < ApplicationController
  before_action :set_prescriptions_medicine, only: %i[show edit destroy]
  before_action :authenticate_user!
  before_action :set_pets, only: %i[show new edit]

  def show
    @pet = Prescription.find_by(id: params[:prescription_id]).pet
  end

  def new
    @prescriptions_medicine = PrescriptionsMedicine.new
    @prescription = Prescription.find_by(id: params[:prescription_id])
    @pet = @prescription.pet
  end

  def edit
    @prescription = @prescriptions_medicine.prescription
    @pet = Prescription.find_by(id: params[:prescription_id]).pet
  end

  def destroy
    @prescriptions_medicine.destroy
    redirect_to pet_medicine_notebook_index_path(@prescriptions_medicine.prescription.pet_id), notice: "処方箋を削除しました"
  end

  private
    def set_prescriptions_medicine
      @prescriptions_medicine = PrescriptionsMedicine.find(params[:id])
    end

    def prescriptions_medicine_params
      params.require(:prescriptions_medicine).permit(:dose, :total_amount, :memo, :medicine_id, :prescription_id)
    end
end
