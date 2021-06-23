# frozen_string_literal: true

class PrescriptionDetailsController < ApplicationController
  before_action :set_prescription_detail, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :set_user_pets, only: %i[show new edit update create]

  def show
    @pet = Prescription.find_by(id: params[:prescription_id]).pet
  end

  def new
    @prescription_detail = PrescriptionDetail.new
    @prescription = Prescription.find_by(id: params[:prescription_id])
    @pet = @prescription.pet
  end

  def create
    #@prescription = Prescription.find_by(id: params[:pet_id])
    @prescription_detail = PrescriptionDetail.new(prescription_detail_params)
    @prescription = @prescription_detail.prescription
    @pet = @prescription_detail.prescription.pet
    if @prescription_detail.save
      redirect_to pet_medicine_notebook_index_path(@prescription_detail.prescription.pet_id), notice:  "prescription was successfully created."
    else
      #こちらもnewのページに移動しない。
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @prescription = @prescription_detail.prescription
    @pet = Prescription.find_by(id: params[:prescription_id]).pet
  end

  def update
    @prescription = @prescription_detail.prescription
    @pet = @prescription_detail.prescription.pet
    if @prescription_detail.update(prescription_detail_params)
      redirect_to prescription_prescription_detail_path(@prescription_detail.prescription_id, @prescription_detail), notice: "prescription was successfully updated."
    else
      #@pet = @prescription_detail.prescription.pet
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prescription_detail.destroy
    redirect_to pet_medicine_notebook_index_path(@prescription_detail.prescription.pet_id), notice: "prescription was successfully destroyed."
  end

  private
    def set_prescription_detail
      @prescription_detail = PrescriptionDetail.find(params[:id])
    end

    def prescription_detail_params
      params.require(:prescription_detail).permit(:quantity, :for_days, :memo, :medicine_id, :prescription_id)
    end

    def set_user_pets
      @pets = current_user.pets
    end
end
