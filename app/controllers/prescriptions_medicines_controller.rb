# frozen_string_literal: true

class PrescriptionsMedicinesController < ApplicationController
  before_action :set_prescriptions_medicine, only: %i[edit destroy]
  before_action :authenticate_user!
  before_action :set_pets, only: %i[new edit]

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
      if PrescriptionsMedicine.find(params[:id]).prescription.pet.user == current_user
        @prescriptions_medicine = PrescriptionsMedicine.find(params[:id])
      end
    end

    def prescriptions_medicine_params
      params.require(:prescriptions_medicine).permit(:dose, :total_amount, :memo, :medicine_id, :prescription_id)
    end
end
