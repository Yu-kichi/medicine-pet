# frozen_string_literal: true

class Api::PrescriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @prescription = Prescription.new(prescription_params)
    # @prescription.user = current_user
    if @prescription.save
      render json: { location: new_prescription_prescriptions_medicine_path(@prescription), notice: "記事を作成しました。" }
    else
      head :bad_request
    end
  end

  private
    def prescription_params
      params.require(:prescription).permit(:date, :medical_fee, :medicine_fee, :pet_id, :clinic_id)
    end
end
