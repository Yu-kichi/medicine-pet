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
    if @clinic.save
      head :no_content
    else
      head :bad_request
    end
  end

  private
    def clinic_params
      params.require(:clinic).permit(:name, :address, :telephone_number, :prefecture_id)
    end
end
