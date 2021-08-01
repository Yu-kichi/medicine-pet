# frozen_string_literal: true

class Api::PrescriptionsMedicinesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_prescriptions_medicine, only: %i[edit update]

  def create
    @prescriptions_medicine = PrescriptionsMedicine.new(prescriptions_medicine_params)
    if @prescriptions_medicine.save
      render json: { location: pet_medicine_notebook_index_path(@prescriptions_medicine.prescription.pet_id), notice:  "prescription was successfully created." }
    else
      head :bad_request
    end
  end

  def edit
  end

  def update
    if @prescriptions_medicine.update(prescriptions_medicine_params)
      render json: { location: prescription_prescriptions_medicine_path(@prescriptions_medicine.prescription_id, @prescriptions_medicine), notice: "prescription was successfully updated." }
    else
      head :bad_request
    end
  end

  private
    def prescriptions_medicine_params
      params.require(:prescriptions_medicine).permit(:dose, :total_amount, :memo, :medicine_id, :prescription_id)
    end

    def set_prescriptions_medicine
      @prescriptions_medicine = PrescriptionsMedicine.find(params[:id])
    end
end
