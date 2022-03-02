# frozen_string_literal: true

class MedicinesController < ApplicationController
  before_action :set_medicine, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :set_pets, only: %i[index show new edit]

  def index
    @medicines = current_user.medicines
  end

  def show
    @pet = Pet.find_by(id: params[:pet_id])
  end

  def new
    @medicine = Medicine.new
    if params[:prescriptions_medicine_id]
      @prescription_medicine = PrescriptionsMedicine.find_by(id: params[:prescriptions_medicine_id])
      @prescription = @prescription_medicine.prescription
    else
      @prescription = Prescription.find_by(id: params[:prescription_id])
    end
    @pet = @prescription.pet
  end

  def create
    @medicine = Medicine.new(medicine_params)
    @medicine.user_id = current_user.id
    @prescription_id = params[:medicine][:prescription]
    @prescription_medicine_id = params[:medicine][:prescription_medicine]
    if @medicine.save
      if @prescription_medicine_id
        redirect_to edit_prescription_prescriptions_medicine_path(@prescription_id, @prescription_medicine_id),
                    notice: "新しく薬の名前を登録しました"
      else
        redirect_to new_prescription_prescriptions_medicine_path(@prescription_id), notice: "新しく薬の名前を登録しました"
      end
    elsif @prescription_medicine_id
      render :new, status: :unprocessable_entity, locals: { prescription_medicine_id: @prescription_medicine_id, prescription_id: @prescription_id }
    else
      render :new, status: :unprocessable_entity, prescription_id: @prescription_id
    end
  end

  def edit
  end

  def update
    if @medicine.update(medicine_params)
      redirect_to medicines_path, notice: "薬の名前を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @medicine.destroy
    redirect_to medicines_url, notice: "薬の名前を削除しました"
  end

  private
    def set_medicine
      @medicine = Medicine.find(params[:id])
    end

    def medicine_params
      params.require(:medicine).permit(:name)
    end
end
