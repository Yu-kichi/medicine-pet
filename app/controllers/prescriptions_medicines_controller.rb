# frozen_string_literal: true

class PrescriptionsMedicinesController < ApplicationController
  before_action :set_prescriptions_medicine, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :set_user_pets, only: %i[show new edit update create]

  def show
    @pet = Prescription.find_by(id: params[:prescription_id]).pet
  end

  def new
    @prescriptions_medicine = PrescriptionsMedicine.new
    @prescription = Prescription.find_by(id: params[:prescription_id])
    @pet = @prescription.pet
  end

  def create
    @prescriptions_medicine = PrescriptionsMedicine.new(prescriptions_medicine_params)
    @prescription = Prescription.find_by(id: params[:prescription_id])
    @prescriptions_medicine.prescription_id = @prescription.id
    @pet = @prescription.pet

    if @prescriptions_medicine.save
      redirect_to pet_medicine_notebook_index_path(@prescriptions_medicine.prescription.pet_id), notice:  "prescription was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @prescription = @prescriptions_medicine.prescription
    @pet = Prescription.find_by(id: params[:prescription_id]).pet
  end

  def update
    @prescription = @prescriptions_medicine.prescription
    @pet = @prescriptions_medicine.prescription.pet
    if @prescriptions_medicine.update(prescriptions_medicine_params)
      redirect_to prescription_prescriptions_medicine_path(@prescriptions_medicine.prescription_id, @prescriptions_medicine), notice: "prescription was successfully updated."
    else
      @pet = @prescriptions_medicine.prescription.pet
      render :edit
    end
  end

  def destroy
    @prescriptions_medicine.destroy
    redirect_to pet_medicine_notebook_index_path(@prescriptions_medicine.prescription.pet_id), notice: "prescription was successfully destroyed."
  end

  private
    def set_prescriptions_medicine
      @prescriptions_medicine = PrescriptionsMedicine.find(params[:id])
    end

    def prescriptions_medicine_params
      params.require(:prescriptions_medicine).permit(:dose, :total_amount, :memo, :medicine_id, :prescription_id)
    end

    def set_user_pets
      @pets = current_user.pets
    end
end
