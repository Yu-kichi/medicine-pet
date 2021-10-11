# frozen_string_literal: true

module Api
  class PrescriptionsMedicinesController < ApplicationController
    before_action :set_prescriptions_medicine, only: %i[edit update destroy]

    def show
      @prescription = Prescription.find(params[:id])
    end

    def create
      @prescriptions_medicine = PrescriptionsMedicine.new(prescriptions_medicine_params)
      if @prescriptions_medicine.save
        head :no_content
      else
        head :bad_request
      end
    end

    def edit; end

    def update
      if @prescriptions_medicine.update(prescriptions_medicine_params)
        head :no_content
      else
        head :bad_request
      end
    end

    def destroy
      @prescriptions_medicine.destroy!
      head :no_content
    end

    private
      def prescriptions_medicine_params
        params.require(:prescriptions_medicine).permit(:dose, :total_amount, :memo, :medicine_id, :prescription_id)
      end

      def set_prescriptions_medicine
        @prescriptions_medicine = PrescriptionsMedicine.find(params[:id])
      end
  end
end
