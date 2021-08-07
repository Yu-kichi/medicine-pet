# frozen_string_literal: true

class Api::PrescriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_prescription, only: %i[edit update destroy]

  def create
    @prescription = Prescription.new(prescription_params)
    if @prescription.save
      render json: { location: new_prescription_prescriptions_medicine_path(@prescription), notice: "処方箋情報を作成しました。" }
    else
      head :bad_request
    end
  end

  def edit
  end

  def update
    if @prescription.update(prescription_params)
      render json: { location: pet_prescription_path(@prescription.pet_id, @prescription), notice: "処方箋情報を編集しました。" }
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
