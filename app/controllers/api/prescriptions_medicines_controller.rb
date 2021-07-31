# frozen_string_literal: true

class Api::PrescriptionsMedicinesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def create
    @prescriptions_medicine = PrescriptionsMedicine.new(prescriptions_medicine_params)
    if @prescriptions_medicine.save
      render json: { location: pet_medicine_notebook_index_path(@prescriptions_medicine.prescription.pet_id), notice:  "prescription was successfully created." }
    else
      head :bad_request
    end
  end

  private
    def prescriptions_medicine_params
      params.require(:prescriptions_medicine).permit(:dose, :total_amount, :memo, :medicine_id, :prescription_id)
    end
end
