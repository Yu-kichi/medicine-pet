# frozen_string_literal: true

class MedicinesController < ApplicationController
  before_action :set_medicine, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :set_pets, only: %i[new]

  def index
    @pet = @pets.find_by(id: params[:pet_id])
    @medicines = Medicine.all
  end

  def show
    @pet = Pet.find_by(id: params[:pet_id])
  end

  def new
    @medicine = Medicine.new
    if params[:prescription_id]
      @prescription = Prescription.find_by(id: params[:prescription_id])
      @pet = @prescription.pet
    else
      @prescription_medicine = PrescriptionsMedicine.find_by(id: params[:prescriptions_medicine_id])
      @prescription = @prescription_medicine.prescription
      @pet = @prescription.pet
    end
  end

  def create
    @medicine = Medicine.new(medicine_params)
    prescription = params[:medicine][:prescription]
    prescription_medicine = params[:medicine][:prescription_medicine]
    if @medicine.save
      if prescription_medicine
        redirect_to edit_prescription_prescriptions_medicine_path(prescription, prescription_medicine), notice:  "新しく薬の名前を登録しました"
      else
        redirect_to new_prescription_prescriptions_medicine_path(prescription), notice:  "新しく薬の名前を登録しました"
      end
    else
      if prescription_medicine
        redirect_to "/medicines/new/?prescriptions_medicine_id=#{prescription_medicine}", alert: @medicine.errors.full_messages[0]
      else
        redirect_to "/medicines/new/?prescription_id=#{prescription}", alert: @medicine.errors.full_messages[0]
      end
    end
  end

  def edit
    @pet = Pet.find_by(id: params[:pet_id])
  end

  def update
    if @medicine.update(medicine_params)
      redirect_to pet_medicine_path(@medicine.pet_id, @medicine), notice: "薬の名前を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pet = Pet.find_by(id: params[:pet_id])
    @medicine.destroy
    if @pet
      redirect_to pet_medicine_notebook_index_path(@pet), notice: "薬の名前を削除しました"
    else
      redirect_to medicines_url, notice: "薬の名前を削除しました"
    end
  end

  private
    def set_medicine
      @medicine = Medicine.find(params[:id])
    end

    def medicine_params
      params.require(:medicine).permit(:name)
    end
end
