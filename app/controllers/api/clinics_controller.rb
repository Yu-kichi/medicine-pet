# frozen_string_literal: true

class Api::ClinicsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def show
    prefecture = Prefecture.find(params[:id])
    @clinics = prefecture.clinics.select(:id, :name)
  end

  def create
    @clinic = Clinic.new(clinic_params)
    pet_id = params[:pet_id]
    prescription_id = params[:prescription_id]
    if @clinic.save
      if prescription_id == "null"
        render json: { location: new_pet_prescription_path(pet_id), notice:  "病院情報を作成しました" }
      else
        render json: { location: edit_pet_prescription_path(pet_id, prescription_id), notice:  "病院情報を作成しました" }
      end
    else
      head :bad_request
    end
  end

  private
    def clinic_params
      params.require(:clinic).permit(:name, :address, :telephone_number, :prefecture_id)
    end
end
