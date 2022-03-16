# frozen_string_literal: true

class API::PrescriptionsMedicinesController < API::BaseController
  before_action :set_prescriptions_medicine, only: %i[edit update destroy]
  before_action :authenticate_user!

  def show
    if Prescription.find(params[:id]).pet.user == current_user
      @prescription = Prescription.includes([:clinic, { prescriptions_medicines: :medicine }]).find(params[:id])
    end
  end

  def create
    @prescriptions_medicine = PrescriptionsMedicine.new(prescriptions_medicine_params)
    if @prescriptions_medicine.save
      render json: { status: "Success", message: "Created the prescriptions_medicine", data: @prescriptions_medicine }
    else
      render json: { status: "Bad Request", message: @prescriptions_medicine.errors.full_messages }
    end
  end

  def edit; end

  def update
    if @prescriptions_medicine.update(prescriptions_medicine_params)
      render json: { status: "Success", message: "Updated the prescriptions_medicine", data: @prescriptions_medicine }
    else
      render json: { status: "Bad Request", message: @prescriptions_medicine.errors.full_messages }
    end
  end

  def destroy
    @prescriptions_medicine.destroy
    render json: { status: "Success", message: "Destroyed the prescriptions_medicine", data: @prescriptions_medicine }
  end

  private
    def prescriptions_medicine_params
      params.require(:prescriptions_medicine).permit(:dose, :total_amount, :memo, :medicine_id, :prescription_id, :unit)
    end

    def set_prescriptions_medicine
      if PrescriptionsMedicine.find(params[:id]).prescription.pet.user == current_user
        @prescriptions_medicine = PrescriptionsMedicine.find(params[:id])
      end
    end
end
