# frozen_string_literal: true

module Api
  class ClinicsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!
    before_action :set_clinic %i[edit update]

    def show
      prefecture = Prefecture.find(params[:id])
      @clinics = prefecture.clinics.select(:id, :name)
    end

    def create
      @clinic = Clinic.new(clinic_params)
      @clinic.user_id = current_user.id
      if @clinic.save
        head :no_content
      else
        head :bad_request
      end
    end
    
    def edit; end

    def update
      if @clinic.update(clinic_params)
        head :no_content
      else
        head :bad_request
      end
    end

    private
      def clinic_params
        params.require(:clinic).permit(:name, :address, :telephone_number, :prefecture_id)
      end

      def set_clinic
        @clinic = clinic.find(params[:id])
      end
  end
end
