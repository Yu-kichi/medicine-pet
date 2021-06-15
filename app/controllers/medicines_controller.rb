# frozen_string_literal: true

class MedicinesController < ApplicationController
  before_action :set_medicine, only: %i[show edit update destroy]
  def index
    @pets = Pet.includes(:clinics, :medicines)
    @pet = @pets.find_by(id: params[:pet_id])
    if @pet
      @medicines = @pet.medicines
    else
      @medicines = Medicine.all
    end
  end

  def show
    @pet = Pet.find_by(id: params[:pet_id])
  end

  def new
    @medicine = Medicine.new
    @clinic = Clinic.find_by(id: params[:clinic_id])
    @pet = Pet.find_by(id: @clinic.pet_id)
  end

  def create
    @medicine = Medicine.new(medicine_params)
    if @medicine.save
      # redirect_to @medicine, notice:  "Medicine was successfully created."
      redirect_to pet_medicine_path(@medicine.pet_id, @medicine), notice: "Medicine was successfully updated."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @pet = Pet.find_by(id: params[:pet_id])
  end

  def update
    if @medicine.update(medicine_params)
      # redirect_to @medicine, notice: "Medicine was successfully updated."
      redirect_to pet_medicine_path(@medicine.pet_id, @medicine), notice: "Medicine was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pet = Pet.find_by(id: params[:pet_id])
    @medicine.destroy
    if @pet
      redirect_to pet_medicine_notebook_index_path(@pet), notice: "Medicine  was successfully destroyed."
    else
      redirect_to medicines_url, notice: "Medicine was successfully destroyed."
    end
  end

  private
    def set_medicine
      @medicine = Medicine.find(params[:id])
    end

    def medicine_params
      params.require(:medicine).permit(:name, :quantity, :memo, :clinic_id, :pet_id)
    end
end
