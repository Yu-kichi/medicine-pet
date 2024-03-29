# frozen_string_literal: true

class API::PrescriptionsController < API::BaseController
  before_action :set_prescription, only: %i[edit update destroy]
  before_action :authenticate_user!

  def show
    if Prescription.find(params[:id]).pet.user == current_user
      @prescription = Prescription.includes([:clinic, { prescriptions_medicines: :medicine }]).find(params[:id])
    end
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
      render json: { status: "Success", location: new_prescription_prescriptions_medicine_path(@prescription) }
    else
      render json: { status: "Bad Request", message: @prescription.errors.full_messages }
    end
  end

  def edit; end

  def update
    if @prescription.update(prescription_params)
      render json: { status: "Success", message: "Updated the prescription", data: @prescription }
    else
      render json: { status: "Bad Request", message: @prescription.errors.full_messages }
    end
  end

  def destroy
    @prescription.destroy
    render json: { status: "Success", message: "Destroyed the prescription", data: @prescription }
  end

  private
    def prescription_params
      params.require(:prescription).permit(:date, :medical_fee, :medicine_fee, :pet_id, :clinic_id)
    end

    def set_prescription
      if Prescription.find(params[:id]).pet.user == current_user
        @prescription = Prescription.find(params[:id])
      end
    end
end
