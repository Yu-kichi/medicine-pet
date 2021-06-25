# frozen_string_literal: true

class PrescriptionsController < ApplicationController
  before_action :set_prescription, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :set_user_pets

  def show
    @pet = Pet.find_by(id: params[:pet_id])
  end

  def new
    @prescription = Prescription.new
    @pet = Pet.find_by(id: params[:pet_id])
  end

  def create
    @prescription = Prescription.new(prescription_params)
    @pet = @prescription.pet
    if @prescription.save
      redirect_to new_prescription_prescription_detail_path(@prescription, @pet), notice:  "prescription was successfully created."
    else
      #ここでindexのURLに飛んでしまう。
      #render 'prescriptions/edit', id: params[:id]
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @pet = Pet.find_by(id: params[:pet_id])
  end

  def update
    @pet = @prescription.pet
    if @prescription.update(prescription_params)
      redirect_to pet_prescription_path(@prescription.pet_id, @prescription), notice: "prescription was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pet = Pet.find_by(id: params[:pet_id])
    @prescription.destroy
    if @pet
      redirect_to pet_medicine_notebook_index_path(@pet), notice: "prescription was successfully destroyed."
    else
      redirect_to prescriptions_url, notice: "prescription was successfully destroyed."
    end
  end

  private
    def set_prescription
      @prescription = Prescription.find(params[:id])
    end

    def prescription_params
      params.require(:prescription).permit(:date, :medical_fee, :medicine_fee, :pet_id, :clinic_id)
    end

    def set_user_pets
      @pets = current_user.pets
    end
end
