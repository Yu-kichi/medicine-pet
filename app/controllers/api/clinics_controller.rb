# frozen_string_literal: true

module Api
  class ClinicsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_clinic, only: %i[edit update]

    def show
      @clinics = Clinic.where(prefecture_id: params[:id]).select(:id, :name)
    end

    def create
      @clinic = Clinic.new(clinic_params)
      if @clinic.save
        render json: { status: "SUCCESS", message: "Updated the clinic", data: @clinic }
      else
        head :bad_request
      end
    end

    def edit; end

    def update
      if @clinic.update(clinic_params)
        render json: { status: "SUCCESS", message: "Updated the clinic", data: @clinic }
      else
        head :bad_request
      end
    end

    private
      def clinic_params
        params.require(:clinic).permit(:name, :address, :telephone_number, :prefecture_id, :user_id)
      end

      def set_clinic
        @clinic = Clinic.find(params[:id])
      end
  end
end
