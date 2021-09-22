# frozen_string_literal: true

class Api::PrescriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_prescription, only: %i[edit update destroy]

  def show
    @prescription = Prescription.includes([:clinic, prescriptions_medicines: :medicine]).find(params[:id])
  end

  def create
    if params[:id]
      source_prescription = Prescription.find(params[:id])
      @prescription = Prescription.new(prescription_params)
      @prescription.copy_from(source_prescription)
    else
      @prescription = Prescription.new(prescription_params)
    end

    if @prescription.save
      render json: { location: new_prescription_prescriptions_medicine_path(@prescription) }
    else
      head :bad_request
    end
  end

  def edit
  end

  def update
    if @prescription.update(prescription_params)
      head :no_content
    else
      head :bad_request
    end
  end

  def destroy
    @prescription.destroy!
    head :no_content
  end

  private
    def prescription_params
      params.require(:prescription).permit(:date, :medical_fee, :medicine_fee, :pet_id, :clinic_id)
    end

    def set_prescription
      @prescription = Prescription.find(params[:id])
    end
end
